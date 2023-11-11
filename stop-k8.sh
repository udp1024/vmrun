echo 'Stopping k8 Cluster 1'
vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-desktop/Ubuntu desktop 22.04.3.vmwarevm" -wait
echo 'k8-desktop stopped'

vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/K8 - cluster w2.vmwarevm" -wait
echo 'k8-w2 stopped'

vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/K8 - cluster w1.vmwarevm" -wait
echo 'k8-w1 stopped'

vmrun -T fusion stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/K8 - cluster m1.vmwarevm" -wait
echo 'k8-m1 stopped. Cluster stopped.'

#read -t 2 -p "waiting for Vmware to cleanly stop the vm ..."
#echo 'Quitting Vmware Fusion'
#osascript -e 'quit app "Vmware Fusion"'
#echo 'Vmware Fusion stopped, exit.'
echo 'done'

