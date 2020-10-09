# Introduction

This [Vagrantfile](Vagrantfile) builds a 2(nodes)+1(controller) virtual machine cluster, for playing with [k3s](https://k3s.io/) (light-weight kubernetes).

Hosts:

0. node1(controller): 192.168.33.20
1. node1:             192.168.33.21
2. node2:             192.168.33.22

All machines are connected by a host-only network.

Each with 1GB memory and 1 core. 

## Prepare images

Node image is based on [ubuntu-focal](http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box).

Prepare metadata for downloaded box files:

[reference](https://stackoverflow.com/questions/32607741/vagrant-setup-virtualbox-name-with-box-version-from-json-file)

Create *focal-server-cloudimg-amd64-vagrant.json* with following content:

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

Add downloaded box, its version and name will be set by this json file.

```bash
vagrant box add focal-server-cloudimg-amd64-vagrant.json
```

Confirm the box is in position:

```bash
vagrant box list
```

[Package preparation](packages/README.md).

## Boot up cluster

Simple like this:

```bash
vagrant up
```

Confirm cluster is ready:

```bash
...\k3s-tutorial> vagrant status
Current machine states:

node0                     running (virtualbox)
node1                     running (virtualbox)
node2                     running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

## Run k3s

On node0 (controller):

```bash
vagrant ssh node0
...
vagrant@node0:~$ /vagrant/scripts/k3s-server.sh
vagrant@node0:~$ nohup: redirecting stderr to stdout

vagrant@node0:~$
```

Wait a dozen seconds, till controller is ready ...

```bash
vagrant@node0:~$ sudo k3s kubectl get po -A
NAMESPACE     NAME                                     READY   STATUS      RESTARTS   AGE
kube-system   metrics-server-7b4f8b595-njd4r           1/1     Running     0          67s
kube-system   local-path-provisioner-7ff9579c6-dr5ph   1/1     Running     0          67s
kube-system   coredns-66c464876b-h8fpq                 1/1     Running     0          67s
kube-system   helm-install-traefik-l62jf               0/1     Completed   0          67s
kube-system   svclb-traefik-xp8rk                      2/2     Running     0          58s
kube-system   traefik-5dd496474-dkqr7                  1/1     Running     0          58s
kube-system   svclb-traefik-26lr7                      2/2     Running     0          16s
kube-system   svclb-traefik-c7jx7                      2/2     Running     0          16s
vagrant@node0:~$
```

On node{1..}:

```bash
vagrant ssh node1
...
vagrant@node1:~$ /vagrant/scripts/k3s-agent.sh
Warning: Permanently added 'node0,192.168.33.20' (ECDSA) to the list of known hosts.
vagrant@node1:~$ nohup: redirecting stderr to stdout

vagrant@node1:~$
```

Check nodes:

```bash
vagrant@node0:~$ sudo k3s kubectl get no
NAME    STATUS   ROLES    AGE   VERSION
node0   Ready    master   74s   v1.19.2+k3s1
node2   Ready    <none>   16s   v1.19.2+k3s1
node1   Ready    <none>   16s   v1.19.2+k3s1
```

## Shutdown

```bash
vagrant halt
```

## Clean up

```bash
vagrant destroy -f
```

## More useful commands

Consult [Vagrant Documentation](https://www.vagrantup.com/docs).

Also, a brief course: [vagrant-presentation](https://github.com/cs-course/vagrant-presentation).

## Evaluation

- Setup dashboard
  - Grafana + Promtheues
- Generate workload
  - Use commandline
    - Bulk data copy
  - Realworld application
    - Nginx

## Think further

- Performance insulation between containers.

- Performance guarantee for storage volumes.

More insights are encouraged.

---
Zhan.Shi @ 2017-2020
