#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3

cd k8-nodes
. ./common.sh

sudo hostnamectl set-hostname "k8-w1"

sudo cp netplan.w1 /etc/netplan/00-installer-config.yaml
sudo chmod 600 /etc/netplan/00-installer-config.yaml

sudo reboot now
