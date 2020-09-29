#!/bin/bash
TOKEN=`ssh controller sudo cat /var/lib/rancher/k3s/server/node-token`
nohup sudo k3s agent --server https://192.168.33.20:6443 --token $TOKEN > $HOSTNAME.log &
