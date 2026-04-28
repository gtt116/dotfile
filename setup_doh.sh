#!/bin/bash

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then 
  echo "请使用 sudo 运行此脚本"
  exit 1
fi

echo "正在开始配置 DNS-over-HTTPS (DoH)..."

# 1. 安装 dnscrypt-proxy
apt update
apt install -y dnscrypt-proxy dnsutils

# 2. 修改 dnscrypt-proxy 配置
# 使用 sed 直接修改配置文件：强制使用 cloudflare 和 google，开启 TCP 模式
CONFIG_PATH="/etc/dnscrypt-proxy/dnscrypt-proxy.toml"

if [ -f "$CONFIG_PATH" ]; then
    echo "正在优化 dnscrypt-proxy 配置..."
    # 设置上游服务器
    sed -i "s/^server_names = .*/server_names = ['cloudflare', 'google']/" "$CONFIG_PATH"
    # 强制使用 TCP (DoH 必需)
    sed -i "s/^# force_tcp = .*/force_tcp = true/" "$CONFIG_PATH"
    sed -i "s/^force_tcp = .*/force_tcp = true/" "$CONFIG_PATH"
else
    echo "错误：未找到配置文件 $CONFIG_PATH"
    exit 1
fi

# 3. 重启并启用 dnscrypt-proxy
systemctl restart dnscrypt-proxy
systemctl enable dnscrypt-proxy

echo "等待 dnscrypt-proxy 启动..."
sleep 2

# 4. 验证本地解析是否成功 (127.0.2.1 是 dnscrypt-proxy 默认监听位)
CHECK_IP=$(dig @127.0.2.1 ssl.gstatic.com +short | head -n1)
if [[ $CHECK_IP == 142.* ]] || [[ $CHECK_IP == 172.* ]] || [[ $CHECK_IP == 142.* ]]; then
    echo "验证成功：已获取国际 IP ($CHECK_IP)"
else
    echo "警告：解析结果可能仍有异常，获取到的 IP 为: $CHECK_IP"
fi

# 5. 修改 systemd-resolved 配置
RESOLVE_CONF="/etc/systemd/resolved.conf"
echo "正在配置 systemd-resolved 指向 127.0.2.1..."

# 备份原配置
cp $RESOLVE_CONF "${RESOLVE_CONF}.bak"

# 写入新配置
cat > $RESOLVE_CONF <<EOF
[Resolve]
DNS=127.0.2.1
Domains=~.
EOF

# 6. 重启服务并刷新缓存
systemctl restart systemd-resolved
resolvectl flush-caches

echo "------------------------------------------------"
echo "部署完成！"
echo "当前 DNS 状态："
resolvectl status | grep "Current DNS Server"
echo "测试解析 ssl.gstatic.com:"
nslookup ssl.gstatic.com | grep "Address"
echo "------------------------------------------------"
