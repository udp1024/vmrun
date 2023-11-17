# /etc/netplan/00-installer-config.yaml
# This is a generic network config for static IP4 assignment
network:
  renderer: networkd
  ethernets:
    ens33:
      dhcp6: true
      dhcp4: false 
      addresses: 
        - 192.168.1.32/16
      nameservers: 
        addresses:
          - 192.168.1.3
          - 192.168.1.4
      routes:
        - on-link: true
          to: default
          via: 192.168.1.254
  version: 2

