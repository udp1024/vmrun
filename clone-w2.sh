#!/bin/bash
# script to clone a node k8-w2 from template

TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/"
TARGETNAME="k8-w2"
TARGETSETUPSCRIPT="/home/salman/k8-nodes/setup-w2.sh"
TARGETSETUPNETPLAN="//home/salman/k8-nodes/w2.net"

rm -rf $TARGETPATH

vmrun clone "$TEMPLATE" "$TARGET" full -cloneName=$TARGETNAME

vmrun start "$TARGET" &&

TEMPIP=$(vmrun -T fusion getGuestIPAddress "$TARGET" -wait)

echo 'waiting for SSH server to become available'
while ! nc -z $TEMPIP 22 > /dev/null; do
    sleep 1
done

ssh-keygen -R $TEMPIP
ssh salman@$TEMPIP "mkdir /home/salman/k8-nodes"
scp  ~/vmrun/k8-nodes/setup-w2.sh ~/vmrun/k8-nodes/w2.net salman@$TEMPIP:/home/salman/k8-nodes
ssh salman@$TEMPIP $TARGETSETUPSCRIPT

# Get the IP address of the clone
IP_ADDRESS=$(vmrun -T fusion getGuestIPAddress "$TARGET" -wait)

# clear SSH key from known hosts
ssh-keygen -R $IP_ADDRESS

echo 'waiting for SSH server to become available'
while ! nc -z $IP_ADDRESS 22 > /dev/null; do
    sleep 1
done

# SSH to the machine
ssh salman@$IP_ADDRESS

