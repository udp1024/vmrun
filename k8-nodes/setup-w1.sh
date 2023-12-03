#!/bin/bash
# script to change hostname and assign a static ip
# called by _clone.sh
# calls common.sh

cd ~/k8-nodes
sudo hostnamectl set-hostname k8-w1
sudo cp w1.net /etc/netplan/50-cloud-init.yaml

. ./common.sh
