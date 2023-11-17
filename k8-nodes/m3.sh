#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3

cd ~/k8-nodes

sudo hostnamectl set-hostname "k8-m3"
sudo cp /etc/netplan/00-installer-config.yaml ./00-installer-config.yaml.bak
sudo cp netplan.m3 /etc/netplan/00-installer-config.yaml
sudo chmod 600 /etc/netplan/00-installer-config.yaml

# change SSH server keys
sudo /bin/rm -v /etc/ssh/ssh_host_* &&
sudo dpkg-reconfigure openssh-server &&
# remove dhcp lease and lease cache
sudo dhclient -r ens33 && sudo rm /var/lib/dhcp/dhclient.leases && sudo shutdown now

