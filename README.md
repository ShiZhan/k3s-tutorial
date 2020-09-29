# Introduction

2+1 nodes cluster, node image based on [ubuntu-focal](http://cloud-images.ubuntu.com/focal/20200618/focal-server-cloudimg-amd64-vagrant.box).

Hosts:

0. controller: 192.168.33.20
1. node1:      192.168.33.21
2. node2:      192.168.33.22

All machines are connected by a host-only network.

Each with 1GB memory and 2 cores, for 4 core hosts, the minimal setup could be controller + node1. 

## Get and Manage Boxes

To manage metadata for downloaded box files:

[reference](https://stackoverflow.com/questions/32607741/vagrant-setup-virtualbox-name-with-box-version-from-json-file)

Example:

```json
{
    "name": "ubuntu/focal64",
    "versions": [{
        "version": "20200618.0.0",
        "providers": [{
            "name": "virtualbox",
            "url": "focal-server-cloudimg-amd64-vagrant.box"
        }]
    }]
}
```

Add downloaded box using metadata file with box version (without this file, all imported box will begin versioning from 0):

```bash
vagrant box add foo.json
```

Check it out:

```bash
vagrant box list
```

Zhan.Shi @ 2017-2020
