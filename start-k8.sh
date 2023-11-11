#! /bin/bash

declare -a arr=(\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/nfs-server/nfs-server.vmwarevm/nfs-server.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm/k8-w1.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"
)

echo 'Starting k8 cluster 1'
echo 'starting dev desktop with GUI'
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" gui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" -wait

for i in "${arr[@]}"; do
echo 'starting Cluster Node in the background. PID and IP will be output on console'
vmrun start "$i" nogui
vmrun -T fusion getGuestIPAddress "$i" -wait
done
echo 'Cluster Started'

