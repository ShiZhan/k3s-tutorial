#!/bin/bash

# docker packages
PACKAGES="""
    https://mirrors.aliyun.com/docker-ce/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.2.13-2_amd64.deb
    https://mirrors.aliyun.com/docker-ce/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_19.03.11~3-0~ubuntu-focal_amd64.deb
    https://mirrors.aliyun.com/docker-ce/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_19.03.11~3-0~ubuntu-focal_amd64.deb
"""

# package cache
all_packages=""
for p in $PACKAGES; do
    pf="/vagrant/packages/${p##*/}" # get package file name
    [ -f $pf ] || wget $p -O $pf    # download package
    all_packages+="$pf "            # gather file names
done

# install docker from local cache
dpkg -i $all_packages

# copy k3s & load k3s images
cp /vagrant/packages/k3s /usr/local/bin/k3s && chmod +x /usr/local/bin/k3s && docker load -i /vagrant/packages/k3s-airgap-images-amd64.tar

# test images
docker load -i /vagrant/packages/busybox~1.32.0.tar
docker load -i /vagrant/packages/nginx~1.19.2-alpine.tar
