#!/bin/bash
# script called from machine specific clone script
# assumes environment has been set


rm -rf "$TARGETPATH"
if [ $DEBUG = 1 ]; then echo "removed vm. Continue?"; read REPLY ; fi

vmrun clone "$TEMPLATE" "$TARGET" full -cloneName="$TARGETNAME"
if [ $DEBUG = 1 ]; then echo "created clone. Continue?"; read REAPLY ; fi
#echo "setting mac address to generated type"
#cp "$TARGET" "$TARGET.bak"
#sed -e 's/ethernet0\.addressType = "static"/ethernet0.addressType = "generated"/' -e '/^ethernet0\.address =/d' "$TARGET.bak" > "$TARGET"

echo Bootstrapping $TARGETNAME
#vmrun start "$TARGET" nogui &&
#if [ $DEBUG = 1 ]; then vmrun start "$TARGET" ; 
#else vmrun start "$TARGET" nogui
#fi
# # starting with gui seems much faster than without gui
vmrun start "$TARGET"

if [ $DEBUG = 1 ]; then echo "started clone. Continue?"; read REPLY; fi
echo waiting for temporary IP allocation. Use Ctrl-c to abort if script hangs here for longer than 120 seconds
echo "Started at $(date  +%r)"
TEMPIP=$(vmrun -T fusion getGuestIPAddress "$TARGET")
PREFIX=${TEMPIP:0:8} 
while [ "$PREFIX" != "192.168." ]; do
    TEMPIP=$(vmrun -T fusion getGuestIPAddress "$TARGET")
    # printf $(date  +"%I:%H:%S %p\r")
    printf "     ..... $(date +%r) ${TEMPIP:0:36}...\r"
    PREFIX=${TEMPIP:0:8}
    if [ "$PREFIX" = "192.168" ]; then 
        printf "     ..... $(date +%r) ${TEMPIP:0:36}
        break 
    fi
done

echo -e \nTemporary IP allocated $TEMPIP
echo 'waiting for SSH server to become available'
while ! nc -z $TEMPIP 22 > /dev/null; do sleep 1; done
if [ $DEBUG = 1 ]; then echo  "Continue?"; read REPLY; fi

# remove fingerprints associated with this IP from known-hosts
printf "clearing outdated server keys ..."
ssh-keygen -R $TEMPIP
printf "adding new key"
ssh -oStrictHostKeyChecking=accept-new salman@$TEMPIP "mkdir /home/salman/k8-nodes"
# scp k8-nodes/setup-m1.sh k8-nodes/m1.net salman@$TEMPIP:/home/salman/k8-nodes
# scp $TARGETSETUPSCRIPT $TARGETSETUPNETPLAN salman@$TEMPIP:k8-nodes
printf "loading source files"
scp -r ~/vmrun/k8-nodes salman@$TEMPIP: > /dev/null

if [ $DEBUG = 1 ]; then echo "copied setup to clone. Continue?"; read REPLY; fi
printf "starting customization "
ssh salman@$TEMPIP $TARGETSETUPSCRIPT
printf "waiting for customization script to complete execution ..."
#while ping -c1 -t1 $TARGETURL; do : ; done

# next command does nothing untill the ping stops responding. This gives the setup script time to complete execution and reboot the clone
while [ $(ping -c 1 -W 500 -Q $TEMPIP > /dev/null ; echo $?) -eq 0 ]
                        do :
                        done
echo Server rebooted. Waiting for ssh server ...
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done

# clear SSH key from known hosts
printf "clearing outdated ssh keys"
ssh-keygen -R $TEMPIP 
ssh-keygen -R $TARGETURL

#if [ $DEBUG = 1 ]; then echo "ssh is ready. Continue to shutdown the VM?"; read REPLY; fi
echo shutting down the vm
# Shutdown the VM
#ssh -oStrictHostKeyChecking=accept-new salman@$TARGETURL "sudo shutdown now"
#echo Please change the  mac address now
echo 'waiting for server to reboot'
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done
echo Cloning complete for node $TARGETNAME $TARGETURL
echo final reboot initiated to align vmware fusion with machine state
vmrun stop $TARGET &&
vmrun start $TARGET nogui
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done
echo 'waiting for final reboot'
ssh -oStrictHostKeyChecking=accept-new salman@$TARGETURL
