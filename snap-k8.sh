#! /bin/bash
timestamp=$(date "+%Y%m%d%H%M%S")

echo 'Taking snapshots of k8 Cluster 1'
echo '============================= \n'
echo 'taking snapshot of nfs-server'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/nfs-server/nfs-server.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/nfs-server/nfs-server.vmwarevm"
echo '============================= \n'

echo 'taking snapshot of k8-m1'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm"
echo '============================= \n'

echo 'taking snapshot of k8-w1'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-w1/k8-w1.vmwarevm"
echo '============================= \n'

echo 'taking snapshot of k8-w2'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm"
echo '============================= \n'

echo 'taking snapshot of k8-desktop'
vmrun snapshot "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" $timestamp
echo 'done. Snaps in archive are ...'
vmrun listSnapshots "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm"
echo '============================= \n'
echo 'done'

