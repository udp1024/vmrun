#!/bin/bash

# find and set SSH key file
ssh-keygen -l -f ~/.ssh/id_rsa.pub
# Check the exit code
if [ $? -eq 0 ]; then
	export SSHKEY="~/.ssh/id_rsa"
	echo "we will use the $SSHKEY for authentication to the nodes"
else
	echo "\nThe default key ~/.ssh/id_rsa does not exist or it is invalid."
	echo "Please generate a valid key pair using ssh-keygen command and "
	echo "copy the public key to the node template using ssh-Copy-id command."
	echo "If you want to use an alternate key, please enter full path and file name below.\n"
	read -e -p "Enter the full path and file name of your SSH key: " KEYFILE
	export SSHKEY=$KEYFILE
	if [ ! -f $SSHKEY ]; then
		echo "specified SSH key was not found. Exiting with error"
		exit 1
	else
		ssh-keygen -l -f $SSHKEY
		if [ $? -eq 0 ]; then
			echo "The key file is valid and will be used to authenticate SSH connections to nodes."
		else
			echo "The key specified is invalid and cannot be used. Exiting with error"
			exit 1
		fi
	fi
fi

# Take input for VMPATH
#read -p "Enter the path for VMPATH: " VMPATH
# Check if VMPATH environment variable exists 
if [ -z "$VMPATH" ]; then 
	# If VMPATH does not exist, prompt the user to enter the base path for VMs 
	read -e -p "Enter the base path for VMs: " BASEPATH i
	export VMPATH=$BASEPATH
else 
	# If VMPATH exists, use its value as the default for the input prompt otherwise use the user provided value
	read -e -p "Enter the base path for VMs [$VMPATH]: " BASE_PATH 
	export VMPATH=${BASE_PATH:-$VMPATH}
fi

# check if VMPATH exists
if [ -d "$VMPATH" ]; then
	echo "Base VM path exists $VMPATH"
else
	echo "Base VM path does not exist. Exiting with error."
	exit 1
fi

# take input for Template location and name
if [ -z "$TEMPLATEVM" ]; then 
	# If TEMPLATEVM does not exist, prompt the user to enter the base path for VMs 
	read -e -p "Enter the Template VM path and Name (/path/template.vmx): " TEMPLATEVMPATH i
	export TEMPLATEVM="$TEMPLATEVMPATH"
else 
	# If TEMPLATEVM exists, use its value as the default for the input prompt otherwise use the user provided value
	read -p "Enter the base path for VMs [$TEMPLATEVM]: " TEMPLATEVMPATH 
	export TEMPLATEVM=${TEMPLATEVMPATH:-$TEMPLATEVM}
fi

# Check if the file "K8 - cluster node template.vmwarevm" exists in the K8-nodeTemplate directory
#if [ -d "$BASE_PATH/K8-nodeTemplate/K8 - cluster node template.vmwarevm" ]; then
if [[ -f "$TEMPLATEVM" ]]; then
    echo "The file $TEMPLATEVM exists."
else
    echo "The file $TEMPLATEVM does not exist."
	echo "exiting with error"
	exit 1
fi

# Take input for K8DiR
if [ -z $K8DIR ]; then
	read -p "Enter the desired name of the K8 Cluster Directory within $VMPATH [k8cluster1] " K8DIR i
	export K8DIR=${K8DIR:-"k8cluster1"}
else
	export OLDK8DIR=$K8DIR
	read -p "Enter the desired name of the K8 Cluster Directory within $VMPATH [$K8DIR] " K8DIR
	export K8DIR=${K8DIR:-$OLDK8DIR}
fi

echo "Target path $VMPATH/$K8DIR"

if [ -d $VMPATH/$K8DIR ]; then
	echo "The path $K8DIR already exists. Exiting with error."
	exit 1
else
	echo "creating the cluster directory" "$VMPATH/$K8DIR"
	mkdir -p "$VMPATH/$K8DIR"
	if [ ! -d $VMPATH/$K8DIR ]; then
		echo "Error creating directory $VMPATH/$K8DIR - exiting with error."
		exit 1
	else
		export $K8DIR
	fi
fi
