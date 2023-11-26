#! /bin/bash

echo 'Listing snapshots of k8 Cluster 1'
echo '================================= \n'
jim=w,m

for j in ${jim//,/ }; do
        for i in {3..1}; do
        	echo Snapshot of k8-"$j$i"
		vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8$j$i/k8-$j$i.vmwarevm"
		echo '-------------------'
	done
done

echo done

