#!/bin/bash
# script to clone a node k8-m3 from template
cd ~/vmrun
TEMPLATE="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8-tmplt/k8-tmplt.vmwarevm/k8-tmplt.vmx"
TARGET="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m3/k8-m3.vmwarevm/k8-m3.vmx"
TARGETPATH="/Volumes/Crucial X8/VMs/K8 Cluster 1/k8m3/k8-m3.vmwarevm/"
TARGETNAME="k8-m3"
TARGETSETUPSCRIPT="k8-nodes/setup-m3.sh"
TARGETSETUPNETPLAN="k8-nodes/m3.net"
DEBUG=0

TARGETURL="$TARGETNAME.udp1024.com"
. ./_clone.sh
