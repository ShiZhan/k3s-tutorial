#!/bin/bash
# Run cluster controller on node0, specify NIC (host-only network) to avoid ambiguity.
nohup sudo k3s server --docker --flannel-iface enp0s8 > $HOSTNAME.log &
