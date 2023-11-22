#! /bin/bash

# start-k8.sh
# script to start k8's dev desktop and nodes using VMware vmrun command line utility

# setup an array with vm path and name
#source ./k8-arr1.sh

# start mandatory VM's e.g. dev desktop and /or storage providers
# source ./start-k8-desk.sh

echo 'Starting k8 cluster 1'
echo 'starting Cluster Node in the background. PID and IP will be output on console'

#for i in "${arr1[@]}"; do
#echo processing "$i"
#vmrun start "$i" nogui
#vmrun -T fusion getGuestIPAddress "$i" -wait
#done

jim=m,w
for j in ${jim//,/ }; do
	for i in {1..3}; do
		echo -n "starting k8-$j$i on IP " ; 
		vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8$j$i/k8-$j$i.vmwarevm/k8-$j$i.vmx" nogui;
		vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8$j$i/k8-$j$i.vmwarevm/k8-$j$i.vmx" -wait
	done
done
echo 'Cluster Started'

