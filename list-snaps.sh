#! /bin/bash

declare -a arr=(\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/K8 - cluster w2.vmwarevm"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm"\
)

for i in "${arr[@]}"; do
		printf %"s " Listing snapshots for vm "$i" 
		echo
		vmrun listSnapshots "$i"
		printf '===============================\n\n'
done

