#!/bin/bash
# script to re-arm the template and make it ready for first-boot as a new clone


# disable cloud-init
sudo touch /etc/cloud/cloud-init.disabled

# setup a generic DHCP enabled net plan
sudo rm /etc/netplan/00-installer-config.yaml
sudo cp ~/k8-nodes/tmplt.net /etc/netplan/50-cloud-init.yaml
sudo chmod 0600 /etc/netplan/50-cloud-init.yaml

# setup the first boot script and service
sudo cp ~/k8-nodes/first-boot.service /etc/systemd/system/
sudo cp ~/k8-nodes/firstboot.sh /usr/local/bin/firstboot.sh
sudo chmod +x /usr/local/bin/firstboot.sh
sudo systemctl daemon-reload
sudo systemctl enable first-boot.service

# reset machine id
sudo rm -f /etc/machine-id && sudo touch /etc/machine-id

#SSH Server Generate new keys
sudo /bin/rm -v /etc/ssh/ssh_host_* 

# release ip dhcp lease and remove cache
sudo dhclient -r ens192 && sudo rm /var/lib/dhcp/dhclient.leases

# shutdown
sudo shutdown now
