#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3
# called by setup-??.sh

cd ~/k8-nodes

# change SSH server keys
# sudo /bin/rm -v /etc/ssh/ssh_host_* 
# sudo dpkg-reconfigure -fteletype openssh-server 
# already done in _clone.sh script

# remove dhcp lease and lease cache
sudo rm /var/lib/dhcp/dhclient.leases 
# sudo rm /etc/machine-id 
# sudo systemd-machine-id-setup 
sudo dhclient -r ens33 
sudo reboot 
