#!/bin/bash

echo 'starting dev desktop with GUI'
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" gui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" -wait

