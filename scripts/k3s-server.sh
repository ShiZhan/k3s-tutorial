#!/bin/bash
nohup sudo k3s server --flannel-iface enp0s8 > $HOSTNAME.log &
