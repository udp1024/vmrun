#!/bin/bash
# script called from machine specific clone script
# assumes environment has been set
# called by clone-??.sh

echo "Deleting existing instance, if any"
rm -rf "$TARGETPATH"
if [ $DEBUG = 1 ]; then echo "removed vm. Continue?"; read REPLY ; fi

echo "cloning template to target"
vmrun clone "$TEMPLATE" "$TARGET" full -cloneName="$TARGETNAME"
if [ $DEBUG = 1 ]; then echo "created clone. Continue?"; read REAPLY ; fi

echo "setting mac address to generated type"
cp "$TARGET" "$TARGET.bak"
sed -e 's/ethernet0\.addressType = "static"/ethernet0.addressType = "generated"/' -e '/^ethernet0\.address =/d' "$TARGET.bak" > "$TARGET"
rm "$TARGET.bak"

echo Bootstrapping $TARGETNAME. This will take a while as a new machine id is set, new SSH keys are generated, and the vm is booted twice
#vmrun start "$TARGET" nogui &&
# # starting with gui seems much faster than without gui
vmrun start "$TARGET"

if [ $DEBUG = 1 ]; then echo "started clone. Continue?"; read REPLY; fi
echo waiting for temporary IP allocation. Use Ctrl-c to abort if script hangs here for longer than 120 seconds
echo "Started at $(date  +%r)"
TEMPIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "$TARGET" -wait)

# PREFIX=${TEMPIP:0:8} 
# while [ "$PREFIX" != "192.168." ]; do
#     TEMPIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "$TARGET")
#     # printf $(date  +"%I:%H:%S %p\r")
#     printf "     ..... $(date +%r) ${TEMPIP:0:36}...\r"
#     PREFIX=${TEMPIP:0:8}
#     if [ "$PREFIX" = "192.168." ]; then 
#         printf "     ..... $(date +%r) ${TEMPIP:0:36}"
#         break 
#     fi
# done

echo -e \nTemporary IP allocated $TEMPIP
echo 'waiting for SSH server to become available'
while ! nc -z $TEMPIP 22 > /dev/null; do sleep 1; done
if [ $DEBUG = 1 ]; then echo  "Continue?"; read REPLY; fi

printf "clearing outdated server keys ..."
ssh-keygen -R $TEMPIP

printf "adding new key"
ssh -oStrictHostKeyChecking=accept-new salman@$TEMPIP "mkdir -p ~/k8-nodes"
printf "loading source files\n"
scp -pr $SCRIPT_DIR/k8-nodes salman@$TEMPIP:

if [ $DEBUG = 1 ]; then echo "copied setup script $TARGETSETUPSCRIPT to clone at $TEMPIP. Continue?"; read REPLY; fi
printf "starting customization \n"
ssh salman@$TEMPIP "$TARGETSETUPSCRIPT"
printf "waiting for customization script to complete execution ..."
#while ping -c1 -t1 $TARGETURL; do : ; done
# next command does nothing untill the ping stops responding. This gives the setup script time to complete execution and reboot the clone
# while [ $(ping -c 1 -W 500 -Q $TEMPIP > /dev/null ; echo $?) -eq 0 ]
#                         do :
#                         done

# after customization, the node should come up on its fqdn. we test for ssh
echo Server rebooted. Waiting for ssh server ...
while ! nc -z $TARGETURL 22 > /dev/null; do sleep 1; done

# clear SSH key from known hosts
printf "clearing outdated ssh keys"
ssh-keygen -R $TEMPIP 
ssh-keygen -R $TARGETURL
ssh -oStrictHostKeyChecking=accept-new salman@$TARGETURL "sudo run-parts /etc/update-motd.d/ >/dev/null"
echo Cloning complete for node $TARGETNAME $TARGETURL
