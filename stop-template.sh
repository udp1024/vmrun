#!/bin/bash

echo "Stopping K8-template node ..."

TEMPLATEIP=$(vmrun -T fusion getGuestIPAddress "/Volumes/Crucial X8/VMs/K8 Cluster 1/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx" -wait)

echo 'vm running on ip ' $TEMPLATEIP
echo "sending stop command .."

vmrun stop "/Volumes/Crucial X8/VMs/K8 Cluster 1/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx"

echo "command sent. Starting check. If script hangs here, please break and investigate why the vm is still running...."

while ping -c1 -t1 192.168.1.138; do : ; done

echo -e "\nhost stopped. Check passed. Done"

