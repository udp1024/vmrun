#!/bin/bash
# script to clone a node k8-w2 from template
cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/k8-w2.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8w2/k8-w2.vmwarevm/"
TARGETNAME="k8-w2"
TARGETSETUPSCRIPT="k8-nodes/setup-w2.sh"
TARGETSETUPNETPLAN="k8-nodes/w2.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh

