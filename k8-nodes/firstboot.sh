#!/bin/bash
# script to configure the system only on the first boot
# trigger is set by rearm-tmplt.sh which is executed as the last step of template prep

logger -p local0.info -t first-boot "Started execution - first-boot.sh"

# set generic DHCP netplan
logger -p local0.info -t first-boot "setting netplan"
sudo rm /etc/netplan/00-installer-config.yaml
sudo cp /home/salman/k8-nodes/tmplt.net /etc/netplan/50-cloud-init.yaml
sudo chmod 0600 /etc/netplan/50-cloud-init.yaml
sudo netplan apply

# updating motd
logger -p local0.info -t first-boot "updating motd"
sudo run-parts /etc/update-motd.d/

# make a new /etc/machine-id
logger -p local0.info -t first-boot "setting up machine-id"
sudo systemd-machine-id-setup

# make ssh certs
logger -p local0.info -t first-boot "re-configuring SSH"
sudo dpkg-reconfigure openssh-server
sudo sed -i -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config 

# disable the first-boot.service
logger -p local0.info -t first-boot "disabling the first-boot service"
sudo systemctl disable first-boot.service

# reboot for changes to take effect
logger -p local0.info -t first-boot "rebooting"
sudo reboot
