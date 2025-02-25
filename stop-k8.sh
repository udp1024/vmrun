#!/bin/bash

# stop-k8.sh
# script to stop k8's dev desktop and nodes using VMware vmrun command line utility

# setup an array with vm path and name
#source ./k8-arr1.sh

# stop mandatory VM's e.g. dev desktop and /or storage providers
# source ./stop-k8-desk.sh

echo 'Stopping k8 cluster 1'

#for i in "${arr[@]}"; do
#echo 'stopping Node... ' "$i"
#vmrun -T fusion stop "$i" -wait
#done

jim=w,m
for j in ${jim//,/ }; do
        for i in {3..1}; do
		NODE="k8-$j$i"
		echo "Stopping $NODE - waiting for the host to go down"
		#vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8$j$i/k8-$j$i.vmwarevm/k8-$j$i.vmx" wait;
		NODEIP=$(vmrun -T ws getGuestIPAddress "/data/vms/k8cluster1/$NODE/$NODE.vmx" wait)
		vmrun -T ws stop "/data/vms/k8cluster1/$NODE/$NODE.vmx";
		# while [ $(ping -c 1 -W 500 $NODEIP > /dev/null ; echo $?) -eq 0 ] 
		# 	do :
		# 	done
		# echo "$NODE is down"
        done
done
echo 'Cluster Stopped'

#read -t 2 -p "waiting for Vmware to cleanly stop the vm ..."
#echo 'Quitting Vmware Fusion'
#osascript -e 'quit app "Vmware Fusion"'
#echo 'Vmware Fusion stopped, exit.'
echo 'done'