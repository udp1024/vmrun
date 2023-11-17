#!/bin/bash

# stop-k8.sh
# script to stop k8's dev desktop and nodes using VMware vmrun command line utility

# setup an array with vm path and name
source ./k8-arr1.sh

# stop mandatory VM's e.g. dev desktop and /or storage providers
# source ./stop-k8-desk.sh

echo 'Stopping k8 cluster 1'

for i in "${arr[@]}"; do
echo 'stopping Node... ' "$i"
vmrun -T fusion stop "$i" -wait
done
echo "Cluster Stopped."

#read -t 2 -p "waiting for Vmware to cleanly stop the vm ..."
#echo 'Quitting Vmware Fusion'
#osascript -e 'quit app "Vmware Fusion"'
#echo 'Vmware Fusion stopped, exit.'
echo 'done'

