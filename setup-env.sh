#!/bin/bash

# Take input for VMPATH
#read -p "Enter the path for VMPATH: " VMPATH
# Check if VMPATH environment variable exists 
if [ -z "$VMPATH" ]; then 
	# If VMPATH does not exist, prompt the user to enter the base path for VMs 
	read -p "Enter the base path for VMs: " BASE_PATH i
else 
	# If VMPATH exists, use its value as the default for the input prompt otherwise use the user provided value
	read -p "Enter the base path for VMs [$VMPATH]: " BASE_PATH 
	BASE_PATH=${BASE_PATH:-$VMPATH}
fi

# Check if the file "K8 - cluster node template.vmwarevm" exists in the K8-nodeTemplate directory
if [ -d "$BASE_PATH/K8-nodeTemplate/K8 - cluster node template.vmwarevm" ]; then
        echo "The file 'K8 - cluster node template.vmwarevm' exists in the K8-nodeTemplate directory."
	echo "setting env variable VMPATH to $BASE_PATH"
	export VMPATH=$BASE_PATH
else
        echo "The file 'K8 - cluster node template.vmwarevm' does not exist in $BASE_PATH/K8-nodeTemplate directory."
	echo "exiting with error"
	exit 1
fi


# Take input for K8DiR
if [ -z $K8DIR ]; then
	read -p "Enter the desired name of the K8 Cluster Directory within $VMPATH [k8cluster1] " K8DIR i
	K8DIR=${K8DIR:-"k8cluster1"}
else
	export OLDK8DIR=$K8DIR
	read -p "Enter the desired name of the K8 Cluster Directory within $VMPATH [$K8DIR] " K8DIR
	K8DIR=${K8DIR:-$OLDK8DIR}
fi

echo "Target path $VMPATH/$K8DIR"

if [ -d $VMPATH/$K8DIR ]; then
	echo "The path $K8DIR already exists. Exiting with error."
	exit 1
else
	echo "creating the cluster directory"
	mkdir -p $VMPATH/$K8DIR
	if [ ! -d $VMPATH/$K8DIR ]; then
		echo "Error creating directory $VMPATH/$K8DIR - exiting with error."
		exit 1
	else
		export $K8DIR
	fi
fi
