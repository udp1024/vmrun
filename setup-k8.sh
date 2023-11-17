#! /bin/bash
# setup-k8.sh
# script to clone k8 node template clones using VMware vmrun command line utility

# setup an array with vm path
source ./k8-arr1.sh
source ./k8-arr2.sh


echo 'Starting to clone ...'
for (( q=0; q < ${#arr1[@]}; ++q)); do
#for (( q=0; q < 2; ++q)); do
	echo processing ${arr2[$q]}
	vmrun -T fusion clone "/Volumes/Crucial X8/VMs/K8 Cluster 1/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx" "${arr1[$q]}" full
	vmrun start "${arr1[$q]}" nogui
	NODEIP=$(vmrun -T fusion getGuestIPAddress "${arr1[$q]}" -wait)
	KUSTOMIZE='/home/salman/k8-nodes/'${arr2[$q]}'.sh'
	echo running command \""$KUSTOMIZE"\"
	ssh-keygen -R $NODEIP
	ssh -oStrictHostKeyChecking=accept-new salman@$NODEIP \""$KUSTOMIZE"\"
done
echo 'Cluster Started'

