
kubeadm init --pod-network-cidr=10.244.0.0/16

# https://gist.github.com/rkaramandi/44c7cea91501e735ea99e356e9ae7883
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

# https://adamtheautomator.com/kubernetes-dashboard/	
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml

kubectl apply admin-user.yaml

kubectl -n kubernetes-dashboard create token admin-user
