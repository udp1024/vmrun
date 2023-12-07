#!/bin/bash
# script to clone a node from template
# calls _clone.sh

cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/k8-m1.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m1/k8-m1.vmwarevm/"
TARGETNAME="k8-m1"
TARGETSETUPSCRIPT="/home/salman/k8-nodes/setup-m1.sh"
TARGETSETUPNETPLAN="/home/salman/k8-nodes/m1.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh
