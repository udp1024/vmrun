#!/bin/bash
# script to setup kubernetes primary

kubeadm config images pull

sudo kubeadm init --control-plane-endpoint=k8-m1.udp1024.com \
    --pod-network-cidr=172.16.0.0/16 --apiserver-advertise-address=k8-m1.udp1024.com \
    --cri-socket=/var/run/containerd/containerd.sock \
    --skip-phases=addon/kube-proxy > ~/kube-init.out

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
