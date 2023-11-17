#!/bin/bash

# test-start.sh
# shell script to test source include feature of bash

# setup an array with vm path and name
source ./k8-arr1.sh

# start mandatory VM's e.g. dev desktop and /or storage providers 
#source ./start-k8-desk.sh

# loop through the cluster nodes to start them
for i in "${arr[@]}"; do
echo 'starting Cluster Node in the background. PID and IP will be output on console'
echo  processing "$i"
#vmrun start "$i" nogui
#vmrun -T fusion getGuestIPAddress "$i" -wait
done
echo 'Cluster Started'

