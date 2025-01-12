#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3

cd k8-nodes
. ./common.sh

sudo hostnamectl set-hostname "k8-m3"

sudo cp netplan.m3 /etc/netplan/00-installer-config.yaml
sudo chmod 600 /etc/netplan/00-installer-config.yaml

sudo reboot now
