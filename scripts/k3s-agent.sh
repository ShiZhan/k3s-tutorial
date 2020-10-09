#!/bin/bash
# Get cluster token from node0 (controller)
TOKEN=`ssh node0 sudo cat /var/lib/rancher/k3s/server/node-token`

# Run agent on node{1..} to join cluster
nohup sudo k3s agent --docker --server https://node0:6443 --flannel-iface enp0s8 --token $TOKEN > $HOSTNAME.log &
