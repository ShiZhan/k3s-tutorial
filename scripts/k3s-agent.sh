#!/bin/bash
TOKEN=`ssh controller sudo cat /var/lib/rancher/k3s/server/node-token`
# NODE_IP=`ip add show dev enp0s8 | sed -nr 's#^.*inet (.*)/24.*$#\1#gp'`
# nohup sudo k3s agent --server https://controller:6443 --node-ip $NODE_IP --token $TOKEN > $HOSTNAME.log &
nohup sudo k3s agent --server https://controller:6443 --flannel-iface enp0s8 --token $TOKEN > $HOSTNAME.log &
