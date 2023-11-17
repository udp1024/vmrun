#!/bin/bash

# script to release DHCP address and clear cache
sudo dhclient -r ens33 && 
	sudo rm /var/lib/dhcp/dhclient.leases && 
	sudo rm -rf /etc/machine-id &&
	sudo systemd-machine-id-setup &&
	sudo shutdown now

