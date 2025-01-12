#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3
# called by setup-??.sh

cd ~/k8-nodes
sudo rm -rf /etc/machine-id
sudo systemd-machine-id-setup

sudo cp 99-disable-network-config.cfg /etc/cloud/cloud.cfg.d/
#sudo mv /etc/netplan/00-installer-config.yaml ./00-installer-config.yaml.bak
sudo mv /etc/netplan/50-cloud-init.yaml ./50-cloud-init.yaml.bak

# change SSH server keys
sudo /bin/rm -v /etc/ssh/ssh_host_* 
sudo dpkg-reconfigure -fteletype openssh-server 

# remove dhcp lease and lease cache
# sudo rm /var/lib/dhcp/dhclient.leases 
# sudo rm /etc/machine-id 
# sudo systemd-machine-id-setup 
# sudo dhclient -r ens33 
# sudo reboot 
# sudo networkctl renew ens33
