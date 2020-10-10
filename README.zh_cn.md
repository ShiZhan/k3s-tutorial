# 简介

通过 [Vagrantfile](Vagrantfile) 建立虚拟机机群 (2工作机+1控制机) 以实践 [k3s](https://k3s.io/) (轻量级容器机群kubernetes)。

包含如下虚拟机:

0. node1(controller): 192.168.33.20
1. node1:             192.168.33.21
2. node2:             192.168.33.22

全机经 host-only network 互联。

各机分配 1GB 主存及 1 核。

## 准备镜像

使用 [ubuntu-focal](http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box) 做基础镜像。

为 Vagrant box 准备元数据文件:

[参考](https://stackoverflow.com/questions/32607741/vagrant-setup-virtualbox-name-with-box-version-from-json-file)

建立 *focal-server-cloudimg-amd64-vagrant.json* 文件:

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

将所下载基础镜像 box 添加进 Vagrant 环境，box 版本及镜像名称由元数据文件设置。

```bash
vagrant box add focal-server-cloudimg-amd64-vagrant.json
```

确认 box 已就位:

```bash
vagrant box list
```

[各软件安装包准备](packages/README.md)。

## 启动机群

易如反掌:

```bash
vagrant up
```

确认机群运行状态:

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

## 开启 k3s

在 node0 (控制机) 上:

```bash
vagrant ssh node0
...
vagrant@node0:~$ /vagrant/scripts/k3s-server.sh
vagrant@node0:~$ nohup: redirecting stderr to stdout

vagrant@node0:~$
```

静候约数十秒，直至控制机就绪 ...

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

在工作机 node{1..}:

```bash
vagrant ssh node1
...
vagrant@node1:~$ /vagrant/scripts/k3s-agent.sh
Warning: Permanently added 'node0,192.168.33.20' (ECDSA) to the list of known hosts.
vagrant@node1:~$ nohup: redirecting stderr to stdout

vagrant@node1:~$
```

确认容器机群全机就绪:

```bash
vagrant@node0:~$ sudo k3s kubectl get no
NAME    STATUS   ROLES    AGE   VERSION
node0   Ready    master   74s   v1.19.2+k3s1
node2   Ready    <none>   16s   v1.19.2+k3s1
node1   Ready    <none>   16s   v1.19.2+k3s1
```

## 关闭

```bash
vagrant halt
```

## 清场

```bash
vagrant destroy -f
```

## 更详细操作

看官方文档 [Vagrant Documentation](https://www.vagrantup.com/docs)。

学基础科普 [vagrant-presentation](https://github.com/cs-course/vagrant-presentation)。

## 实验观测

- 建立仪表盘
  - Grafana + Promtheues
- 生成负载
  - 通过命令行操作
    - 批量数据拷贝
  - 部署实际应用
    - Nginx

## 进一步思考

- 容器、虚拟机间性能隔离 (Performance insulation)。

- 存储卷性能保障 (Performance guarantee)。

欢迎深入探索。

---
Zhan.Shi @ 2017-2020
