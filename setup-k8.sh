#! /bin/bash
# setup-k8.sh
# script to clone k8 node template clones using VMware vmrun command line utility
export DEBUG=0

# Get the directory of the current script
export SCRIPT_DIR=$(dirname "$(realpath "$0")")

echo "The setup script is being executed from: $SCRIPT_DIR"

# setup VMware Type env variable
source ./checkos.sh
if [ $? -ne 0 ]; then
        echo "checkos.sh failed to set a valid VMware Type. Exiting setup." 
        # Handle the error as needed
        exit 1
fi

# setup VMPATH env variable
source ./setup-env.sh
# Check the exit status of the sub-script 
if [ $? -ne 0 ]; then 
	echo "The VM path is invalid. Exiting setup." 
	# Handle the error as needed
	exit 1
else 
	echo "VM path found $VMPATH. Cluster Directory $K8DIR created."
fi

#setup an array with vm path
source ./k8-arr1.sh
# Check the exit status of the sub-script 
if [ $? -ne 0 ]; then
        echo "k8-arr1.sh failed. Exiting setup." 
        # Handle the error as needed
        exit 1
fi

source ./k8-arr2.sh
# Check the exit status of the sub-script 
if [ $? -ne 0 ]; then
        echo "k8-arr2.sh failed. Exiting setup." 
        # Handle the error as needed
        exit 1
fi

echo 'Starting to clone ...'
for (( q=0; q < ${#arr2[@]}; ++q)); do
#for (( q=0; q < 2; ++q)); do
	echo "processing k8-${arr2[$q]}"
	# vmrun -T $VMWARETYPE clone  "$VMPATH/K8-nodeTemplate/K8 - cluster template.vmwarevm/K8 - cluster node template.vmx" "${arr1[$q]}" full
	export TARGETNODE="$VMPATH/$K8DIR/k8-${arr2[$q]}/k8-${arr2[$q]}.vmx"
	#vmrun -T $VMWARETYPE clone  "$VMPATH/K8-nodeTemplate/K8 - cluster node template.vmwarevm/K8 - cluster node template.vmx" "$TARGETNODE" full -cloneName="k8-${arr2[$q]}"
	vmrun -T $VMWARETYPE clone  "$TEMPLATEVM" "$TARGETNODE" full -cloneName="k8-${arr2[$q]}"
	# vmrun start "${arr1[$q]}" nogui
	vmrun -T $VMWARETYPE start "$TARGETNODE" nogui
	# NODEIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "${arr1[$q]}" -wait)
	export NODEIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "$TARGETNODE" -wait)
	
	echo "Node k8-${arr2[$q]} has started on temporary IP $NODEIP"
	echo 'waiting for SSH server to become available'
	while ! nc -z $NODEIP 22 &> /dev/null; do sleep 1; done
	if [ $DEBUG = 1 ]; then echo  "Continue?"; read REPLY; fi
	
	# remove the host from know_hosts local list
	ssh-keygen -R $NODEIP
	printf "adding new node key. Using $SSHKEY to authenticate"
	# ssh -oStrictHostKeyChecking=accept-new -i $SSHKEY ubuntu@$NODEIP "mkdir -p k8-nodes"
	echo "waiting 2 seconds"
	sleep 2
	printf "loading source files\n"
	scp -oStrictHostKeyChecking=accept-new -pr k8-nodes ubuntu@$NODEIP:
	echo "waiting for SSH server to accept connection"
	sleep 2
	while ! nc -z $NODEIP 22 &> /dev/null; do sleep 1; done
	if [ $DEBUG = 1 ]; then echo "copied setup script $TARGETSETUPSCRIPT to clone at $NODEIP. Continue?"; read REPLY; fi
	KUSTOMIZE='k8-nodes/'${arr2[$q]}'.sh'
	echo preparing to run command \""$KUSTOMIZE"\"
	ssh ubuntu@$NODEIP \""$KUSTOMIZE"\"

	while ping -q -c 1 $NODEIP &> /dev/null; do sleep 1; done; echo "node has rebooted. Waiting for SSH server to return online"
	sleep 5
	export NODEIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "$TARGETNODE" -wait)
	while ! nc -z $NODEIP 22 &> /dev/null; do sleep 1; done;
	echo "k8-${arr2[$q]} has changed its IP address to: $NODEIP. Removing old SSH server id"
	ssh-keygen -R $NODEIP
done
echo 'Cluster Started'

