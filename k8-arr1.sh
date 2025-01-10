if [ -z "$VMWARETYPE" ]; then
	echo "Variable VMWARETYPE not set. Exiting with error."
	exit 1
fi

if [ -z "$VMPATH" ]; then
	echo "Variable VMPATH does not exist. Exiting setup."
	exit 1
fi

if [ -z "$K8DIR" ]; then
        echo "Variable K8DIR does not exist. Exiting setup."
        exit 1
fi

declare -a arr1=(\
        "$VMPATH/$K8DIR/k8m1/k8-m1.vmwarevm/k8-m1.vmx"\
        "$VMPATH/$K8DIR/k8m2/k8-m2.vmwarevm/k8-m2.vmx"\
        "$VMPATH/$K8DIR/k8m3/k8-m3.vmwarevm/k8-m3.vmx"\
        "$VMPATH/$K8DIR/k8w1/k8-w1.vmwarevm/k8-w1.vmx"\
        "$VMPATH/$K8DIR/k8w2/k8-w2.vmwarevm/k8-w2.vmx"\
        "$VMPATH/$K8DIR/k8w3/k8-w3.vmwarevm/k8-w3.vmx"
)

