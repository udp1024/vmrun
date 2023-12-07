#!/bin/bash
# script to clone a node from template
# calls _clone.sh

cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m2/k8-m2.vmwarevm/k8-m2.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m2/k8-m2.vmwarevm/"
TARGETNAME="k8-m2"
TARGETSETUPSCRIPT="/home/salman/k8-nodes/setup-m2.sh"
TARGETSETUPNETPLAN="/home/salman/k8-nodes/m2.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh
