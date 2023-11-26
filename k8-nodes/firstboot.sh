#!/bin/bash
# script to configure the system only on the first boot

# make a new /etc/machine-id
sudo systemd-machine-id-setup

# make ssh certs
sudo dpkg-reconfigure openssh-server

# disable the first-boot.service
sudo systemctl disable first-boot.service
