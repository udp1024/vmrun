#!/bin/bash
timestamp=$(date "+%Y%m%d%H%M%S")

echo 'Taking snapshots of k8 Cluster 1'
echo '============================= \n'
jim=w,m
for j in ${jim//,/ }; do
        for i in {3..1}; do
        	echo 'taking snapshot of k8-'$j$i
		TARGET="/data/vms/k8cluster1/k8-"$j$i"/k8-"$j$i".vmx"
		echo $(vmrun snapshot "$TARGET" $timestamp)
	done
done

echo '============================= \n'
vmrun listSnapshots "$TARGET"
echo done.

