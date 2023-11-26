#!/bin/bash
# script to clone a node k8-m1 from template
cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/"
TARGETNAME="k8-m1"
TARGETSETUPSCRIPT="k8-nodes/setup-m1.sh"
TARGETSETUPNETPLAN="k8-nodes/m1.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"

rm -rf "$TARGETPATH"
if [ $DEBUG = 1 ]; then echo "removed vm. Continue?"; read REPLY ; fi

vmrun clone "$TEMPLATE" "$TARGET" full -cloneName="$TARGETNAME"
if [ $DEBUG = 1 ]; then echo "created clone. Continue?"; read REAPLY ; fi
#echo "setting mac address to generated type"
#cp "$TARGET" "$TARGET.bak"
#sed -e 's/ethernet0\.addressType = "static"/ethernet0.addressType = "generated"/' -e '/^ethernet0\.address =/d' "$TARGET.bak" > "$TARGET"

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
# scp k8-nodes/setup-m1.sh k8-nodes/m1.net salman@$TEMPIP:/home/salman/k8-nodes
scp $TARGETSETUPSCRIPT $TARGETSETUPNETPLAN salman@$TEMPIP:k8-nodes

if [ $DEBUG = 1 ]; then echo "copied setup to clone. Continue?"; read REPLY; fi
ssh salman@$TEMPIP $TARGETSETUPSCRIPT
echo waiting for setup script to complete execution ...
#while ping -c1 -t1 $TARGETURL; do : ; done
# next command does nothing untill the ping stops responding. This gives the setup script to complete execution and reboot the clone
while [ $(ping -c 1 -W 500 -Q $TEMPIP > /dev/null ; echo $?) -eq 0 ]
                        do :
                        done
echo Server rebooted. Waiting for ssh server ...
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done

# clear SSH key from known hosts
ssh-keygen -R $TEMPIP $IP_ADDRESS $TARGETURL
#if [ $DEBUG = 1 ]; then echo "ssh is ready. Continue to shutdown the VM?"; read REPLY; fi

# Shutdown the VM
#ssh -oStrictHostKeyChecking=accept-new salman@$TARGETURL "sudo shutdown now"
#echo Please change the  mac address now
echo Cloning complete for node $TARGETNAME $TARGETURL
