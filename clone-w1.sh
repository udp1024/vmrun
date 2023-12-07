#!/bin/bash
# script to clone a node from template
# calls _clone.sh

cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/k8-w1.vmwarevm/k8-w1.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w1/k8-w1.vmwarevm/"
TARGETNAME="k8-w1"
TARGETSETUPSCRIPT="/home/salman/k8-nodes/setup-w1.sh"
TARGETSETUPNETPLAN="/home/salman/k8-nodes/w1.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh
