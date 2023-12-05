#!/bin/bash
# customization script for k8-node
# nodes are m1,m2,m3 and w1,w2,w3

cd ~/k8-nodes

# change SSH server keys
sudo /bin/rm -v /etc/ssh/ssh_host_* 
sudo dpkg-reconfigure -fteletype openssh-server 
# remove dhcp lease and lease cache
sudo dhclient -r ens33 
	sudo rm /var/lib/dhcp/dhclient.leases 
	sudo rm /etc/machine-id 
	sudo systemd-machine-id-setup 
	sudo reboot 

