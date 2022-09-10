#!/bin/bash

curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
chmod +x ./cephadm
./cephadm add-repo --release quincy
./cephadm install
/usr/sbin/cephadm version

cephadm install ceph-common
cephadm bootstrap --mon-ip `hostname -i` --single-host-defaults

ceph orch device ls
ceph orch apply osd --all-available-devices
ceph orch apply rbd-mirror
