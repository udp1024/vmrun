#! /bin/bash
timestamp=$(date "+%Y%m%d%H%M%S")

echo 'Taking snapshots of k8 Cluster 1'
echo 'taking snapshot of k8-m1'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm"

echo 'taking snapshot of k8-w1'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm"

echo 'taking snapshot of k8-w2'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/K8 - cluster w2.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/K8 - cluster w2.vmwarevm"

echo 'taking snapshot of k8-desktop'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm"

