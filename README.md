<p align="center">
<img src="https://miro.medium.com/max/800/1*WpKHLIDsJZgWKJe-SkOtcg.png"  width="200" alt="Kubernetes"></a>
</p>
<h1 align="center">Kubernetes Demo</h1>

<div align="center">

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Status](https://img.shields.io/badge/status-active-success.svg)]()

</div>

<p align="center"> 
A demo project that demonstrate how to deploy and orchestrate containers through Kubernetes 
<br></p>

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Authors](#authors)

## Microk8s cluster

#### Common
- install microk8s

```shell script
$ sudo snap install microk8s --classic --channel=latest/stable
```

- grant if insufficient permissions

```shell script
$ sudo usermod -a -G microk8s $USER
$ sudo chown -f -R $USER ~/.kube
$ sudo microk8s status # check if granted
```

#### Master node
- enable addons

```shell script
$ sudo microk8s enable dns rbac dashboard
```

- add node

```shell script
$ sudo microk8s add-node
```

- add admin user

```shell script
# change name first
$ sh create-admin-user.sh
```

- dashboard

```shell script
sh create-dashboard-admin.sh
```

#### Worker node
- join cluster

```shell script
$ sudo microk8s join 192.168.64.3:25000/13552637535534eaf9e316e943a44dcf # get from add-node
```

## Authors

- [@hokamc](https://github.com/hokamc)
