#!/bin/bash
# script to change hostname and assign a static ip
cd ~/k8-nodes
sudo hostnamectl set-hostname k8-w3
sudo cp w3.net /etc/netplan/50-cloud-init.yaml
sudo chown root:root /etc/netplan/50-cloud-init.yaml
sudo chmod 0600 /etc/netplan/50-cloud-init.yaml
sudo reboot

