# VMrun
A suite of scripts to create a set of Virtual Machines by cloning a template. These virtual machines are intended to be used as hosts for a Kubernetes Cluster on VMWare Workstation, Player or Fusion platform.

## Prerequisites
These scripts depend upon availability of a pre-configured template virtual machine. The contents of the folder k8-nodes must be copied to the home directory of the main account.

When the template is ready, run the k8-nodes/rearm-tmplt.sh to prepare it for cloning. The script will shut down the virtual machine as the final step of its prep. Each time you need to boot the template, always run the rearm-tmplt.sh script as a final step.

## Installation
Copy the scripts suite to a convenient location. E.g. in your home directory, by running the command
> cd && git clone https://github.com/udp1024/vmrun.git
