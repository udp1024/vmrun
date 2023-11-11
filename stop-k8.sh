#!/bin/bash

declare -a arr=(\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm/k8-w1.vmx"\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/nfs-server/nfs-server.vmwarevm/nfs-server.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm/Ubuntu desktop 22.04.3.vmx"\
)

echo 'Stopping k8 Cluster 1'
#vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" -wait
#echo 'k8-desktop stopped'

for i in "${arr[@]}"; do
echo 'stopping Cluster Node... '
vmrun -T fusion stop "$i" -wait
done

echo "Cluster Stopped."

#read -t 2 -p "waiting for Vmware to cleanly stop the vm ..."
#echo 'Quitting Vmware Fusion'
#osascript -e 'quit app "Vmware Fusion"'
#echo 'Vmware Fusion stopped, exit.'
echo 'done'

