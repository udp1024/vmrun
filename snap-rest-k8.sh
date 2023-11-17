#! /bin/bash

declare -a arr=(\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm/k8-w1.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/nfs-server/nfs-server.vmwarevm/nfs-server.vmx"\
	"/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm/Ubuntu desktop 22.04.3.vmx"\
)

declare -a arr=(\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm/k8-w1.vmx"\
        "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"\
)

SNAPNAME=20231111154137

for i in "${arr[@]}"; do
		printf %"s "Reverting snapshots for vm "$i" 
		echo
		vmrun revertToSnapshot "$i" $SNAPNAME
		printf '===============================\n\n'
done

