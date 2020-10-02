#!/bin/bash
nohup sudo k3s server --docker --flannel-iface enp0s8 > $HOSTNAME.log &
