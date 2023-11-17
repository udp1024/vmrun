#! /bin/bash

# start-k8.sh
# script to start k8's dev desktop and nodes using VMware vmrun command line utility

# setup an array with vm path and name
source ./k8-arr1.sh

# start mandatory VM's e.g. dev desktop and /or storage providers
source ./start-k8-desk.sh

echo 'Starting k8 cluster 1'
echo 'starting Cluster Node in the background. PID and IP will be output on console'

for i in "${arr[@]}"; do
echo processing "$i"
vmrun start "$i" nogui
vmrun -T fusion getGuestIPAddress "$i" -wait
done
echo 'Cluster Started'

