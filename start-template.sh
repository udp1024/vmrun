#!/bin/bash

echo "Starting K8-template node without GUI ..."
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx" nogui

TEMPLATEIP=$(vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx" -wait)

echo 'vm started on ip ' $TEMPLATEIP

