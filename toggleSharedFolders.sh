#!/bin/bash
# ************ vmrun/togglesharedfolders.sh ************
# * Author: Salman Siddiqui <udp1024@gmail.com>        *
# * Date created: 2025/01/11                           *
# * Dependencies: VMware Workstation, Player or Fusion *
# * Arguments: none                                    *
# * To Do: convert the VM name to an argument          *
# ******************************************************
TARGETVM="Python Dev"
echo "Disabling Shared Folders for $TARGETVM"
vmrun -T ws disableSharedFolders "$(vmrun -T ws list | grep "$TARGETVM")"
sleep 2
echo "Enabling Shared Folders"
vmrun -T ws enableSharedFolders "$(vmrun -T ws list | grep "$TARGETVM")"


