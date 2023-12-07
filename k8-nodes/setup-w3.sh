#!/bin/bash
# script to change hostname and assign a static ip
# called by _clone.sh via ssh command
# calls common.sh

cd ~/k8-nodes
sudo hostnamectl set-hostname k8-w3
sudo rm /etc/netplan/*.yaml
sudo cp /home/salman/k8-nodes/w3.net /etc/netplan/50-cloud-init.yaml

. ./common.sh
