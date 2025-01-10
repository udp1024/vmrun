#! /bin/bash
# setup-k8.sh
# script to clone k8 node template clones using VMware vmrun command line utility

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
	echo processing ${arr2[$q]}
	# vmrun -T $VMWARETYPE clone  "$VMPATH/K8 - cluster template.vmwarevm/K8 - cluster template.vmx" "${arr1[$q]}" full
	export TARGETNODE="$VMPATH/$K8DIR/k8-${arr2[$q]}/k8-${arr2[$q]}.vmx"
	vmrun -T $VMWARETYPE clone  "$VMPATH/K8 - cluster template.vmwarevm/K8 - cluster template.vmx" "$TARGETNODE" full
	# vmrun start "${arr1[$q]}" nogui
	vmrun start "$TARGETNODE" nogui
	# NODEIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "${arr1[$q]}" -wait)
	NODEIP=$(vmrun -T $VMWARETYPE getGuestIPAddress "$TARGETNODE" -wait)
	KUSTOMIZE='$SCRiPT_DIR/k8-nodes/'${arr2[$q]}'.sh'
	echo running command \""$KUSTOMIZE"\"
	ssh-keygen -R $NODEIP
	ssh -oStrictHostKeyChecking=accept-new ubuntu@$NODEIP \""$KUSTOMIZE"\"
done
echo 'Cluster Started'

