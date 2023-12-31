#!/bin/bash
# customization script for k8-node
# calls common.sh in the same directory
# nodes are m1,m2,m3 and w1,w2,w3

cd ~/k8-nodes

sudo hostnamectl set-hostname "k8-m1"
sudo cp 99-disable-network-config.cfg /etc/cloud/cloud.cfg.d/
sudo mv /etc/netplan/00-installer-config.yaml ./00-installer-config.yaml.bak
sudo cp netplan.m1 /etc/netplan/00-installer-config.yaml

. ./common.sh

