#!/bin/bash
nohup sudo k3s server --docker --no-deploy traefik --flannel-iface enp0s8 > $HOSTNAME.log &
