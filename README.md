# Introduction

This [Vagrantfile](Vagrantfile) builds a 2+1 nodes virtual machine cluster, node image based on [ubuntu-focal](http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box).

Hosts:

0. controller: 192.168.33.20
1. node1:      192.168.33.21
2. node2:      192.168.33.22

All machines are connected by a host-only network.

Each with 1GB memory and 1 core. 

## Get and Manage Boxes

To manage metadata for downloaded box files:

[reference](https://stackoverflow.com/questions/32607741/vagrant-setup-virtualbox-name-with-box-version-from-json-file)

Example:

```json
{
    "name": "ubuntu/focal64",
    "versions": [{
        "version": "0",
        "providers": [{
            "name": "virtualbox",
            "url": "focal-server-cloudimg-amd64-vagrant.box"
        }]
    }]
}
```

Add downloaded box, its version and name will be set by given json file.

```bash
vagrant box add foo.json
```

Or just add directly (not encouraged), its version will begin from 0 automatically, and named with file name.

```bash
vagrant box add focal-server-cloudimg-amd64-vagrant.box
```

Check it out:

```bash
vagrant box list
```

Zhan.Shi @ 2017-2020
