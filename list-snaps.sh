#! /bin/bash

echo 'Listing snapshots of k8 Cluster 1'
echo '================================= \n'
jim=w,m

for j in ${jim//,/ }; do
        for i in {3..1}; do
        	echo Snapshot of k8-"$j$i"
		vmrun listSnapshots "/data/vms/k8cluster1/k8-$j$i/k8-$j$i.vmx"
		echo '-------------------'
	done
done

echo done

