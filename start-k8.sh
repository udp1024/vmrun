echo 'Starting k8 cluster 1'
echo 'starting dev desktop with GUI'
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" gui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" -wait

echo 'starting Cluster Master k8-m1 in the background. PID and IP will be output on console'
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm" nogui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm" -wait

echo 'starting first worker node k8-w1'
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm" nogui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm" -wait

echo 'starting second worker node k8-w2' 
vmrun start "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/K8 - cluster w2.vmwarevm" nogui
vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm" -wait

echo 'Cluster Started'

