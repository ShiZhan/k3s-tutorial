#!/bin/bash
nohup sudo k3s server --node-external-ip 192.168.33.20 > $HOSTNAME.log &
