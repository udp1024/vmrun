#!/bin/bash
# script to re-arm the template and make it ready for first-boot as a new clone


# disable cloud-init
sudo touch /etc/cloud/cloud-init.disabled

# setup the first boot script and service
sudo cp ./first-boot.service /etc/systemd/system/
sudo cp firstboot.sh /usr/local/bin/firstboot.sh
sudo systemctl daemon-reload
sudo systemctl enable first-boot.service

# reset machine id
sudo rm -f /etc/machine-id && sudo touch /etc/machine-id

#SSH Server Generate new keys
sudo /bin/rm -v /etc/ssh/ssh_host_* 

# release ip dhcp lease and remove cache
sudo dhclient -r ens192 && sudo rm /var/lib/dhcp/dhclient.leases

# shutdown
#sudo shutdown now
