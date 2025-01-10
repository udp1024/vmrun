#!/bin/bash
# script to clone a node from template
# calls _clone.sh

if [ -z "$SCRIPT_DIR" ]; then
	echo "Env Variable SCRIPT_DIR not set. Exiting with error"
	exit 1
else
	if [ -d $SCRIPT_DIR ]; then
		cd $SCRIPT_DIR
	else
		echo "Script directory $SCRIPT_DIR does not exist. Exiting with error"
		exit 1
	fi
fi



# cd ~/vmrun
TEMPLATE="$VMPATH/K8-nodeTemplate/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx"
TARGET="$VMPATH/$K8DIR/k8m1/k8-m1.vmwarevm/k8-m1.vmx"
TARGETPATH="$VMPATH/$K8DIR/k8m1/k8-m1.vmwarevm/"
TARGETNAME="k8-m1"
TARGETSETUPSCRIPT="$SCRIPT_DIR/k8-nodes/setup-m1.sh"
TARGETSETUPNETPLAN="$SCRIPT_DIR/k8-nodes/m1.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh
