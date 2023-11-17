#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3

cd ~/k8-nodes

sudo hostnamectl set-hostname "k8-m2"
sudo cp /etc/netplan/00-installer-config.yaml ./00-installer-config.yaml.bak
sudo cp netplan.m2 /etc/netplan/00-installer-config.yaml

. ./common.sh

