#!/bin/bash
# script to setup contianerd and other parameters for a Kubeadm cluster

sudo swapoff -a && sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab && sudo reboot

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

sudo modprobe overlay &&
sudo modprobe br_netfilter &&
sudo tee /etc/modules <<EOF
overlay
br-netfilter
EOF

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo deb-systemd-invoke restart procps.service

sudo apt update
sudo apt install -y containerd

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i -e 's/sandbox_image = "registry.k8s.io\/pause:3.8"/sandbox_image = "registry.k8s.io\/pause:3.9"/g' -e 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

sudo reboot
