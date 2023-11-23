#!/bin/bash
# script to clone a node k8-m2 from template
cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m2/k8-m2.vmwarevm/k8-m2.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m2/k8-m2.vmwarevm/"
TARGETNAME="k8-m2"
TARGETSETUPSCRIPT="k8-nodes/setup-m2.sh"
TARGETSETUPNETPLAN="k8-nodes/m2.net"
DEBUG=1

TARGETURL="$TARGETNAME.udp1024.com"

rm -rf "$TARGETPATH"
if [ $DEBUG = 1 ]; then echo "removed vm. Continue?"; read REPLY ; fi

vmrun clone "$TEMPLATE" "$TARGET" full -cloneName="$TARGETNAME"
if [ $DEBUG = 1 ]; then echo "created clone. Continue?"; read REAPLY ; fi
echo Bootstrapping $TARGETNAME
vmrun start "$TARGET" nogui &&
if [ $DEBUG = 1 ]; then echo "started clone. Continue?"; read REPLY; fi
echo waiting for temporary IP allocation
TEMPIP=$(vmrun -T fusion getGuestIPAddress "$TARGET" -wait)
echo Temporary IP allocated $TEMPIP
echo 'waiting for SSH server to become available'
while ! nc -z $TEMPIP 22 > /dev/null; do sleep 1; done
if [ $DEBUG = 1 ]; then echo  "Continue?"; read REPLY; fi

ssh-keygen -R $TEMPIP
ssh -oStrictHostKeyChecking=accept-new salman@$TEMPIP "mkdir /home/salman/k8-nodes"
# scp k8-nodes/setup-m2.sh k8-nodes/m2.net salman@$TEMPIP:/home/salman/k8-nodes
scp $TARGETSETUPSCRIPT $TARGETSETUPNETPLAN salman@$TEMPIP:k8-nodes

if [ $DEBUG = 1 ]; then echo "copied setup to clone. Continue?"; read REPLY; fi
ssh salman@$TEMPIP $TARGETSETUPSCRIPT
echo waiting for setup script to complete execution ...
while ping -c1 -t1 $TARGETURL; do : ; done
echo ping received. Waiting for ssh server ...
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done

# clear SSH key from known hosts
ssh-keygen -R $IP_ADDRESS $TARGETURL
if [ $DEBUG = 1 ]; then echo "ssh is ready. Continue to shutdown the VM?"; read REPLY; fi

# Shutdown the VM
ssh -oStrictHostKeyChecking=accept-new salman@$TARGETURL "sudo shutdown now"
echo Please change the  mac address now
echo Cloning complete for node $TARGETNAME $TARGETURL
