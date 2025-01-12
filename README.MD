# VMrun
A suite of scripts to create a set of Virtual Machines by cloning a template. These virtual machines are intended to be used as hosts for a Kubernetes Cluster on VMWare Workstation, Player or Fusion platform.

## Prerequisites
A version of VMware, Workstation, Workstation Pro, Player or Fusion must be installed on the machine where these scripts will run.

Review the naming and number of nodes by customizing k8-arr2.sh fille in the main vmrun directory.

Review the netplan for each node (netplan m1 to netplan.w3 in the k8-nodes directory) to ensure that IP addresses used are compatible for your network. 

Ensure DNS entries or host file entries for each node are created and resolving.

Ability to sudo without password must be configured on the VMware host as well as in the template. This can be achieved by running the following command;
> echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
on both the VM host as well as the template.

These scripts depend upon availability of a pre-configured template virtual machine. The contents of the folder k8-nodes must be copied to the home directory of the main account.

When the template is ready, run the k8-nodes/rearm-tmplt.sh to prepare it for cloning. The script will shut down the virtual machine as the final step of its prep. Each time you need to boot the template, always run the rearm-tmplt.sh script as a final step.

Make sure to copy your SSH certificate to the template. The ability to login via SSH with certificate is necessary for the scripts to operate. For more information refer to https://www.ssh.com/academy/ssh - To generate a basic key pair run the command;
> ssh-keygen

Using all defaults for the prompts, you can quickly generate a key pair. Once the key pair is ready, copy the pubic key to the template; e.g.
>ssh-copy-id ubuntu@template

This assumes that your template VM is called template, with user0 defined as ubuntu and ssh keys are present in your home folder as ~/.ssh/id_rsa

## Network
Currently the VMrun suite is hard coded to create six virtual machines with labels k8-m1 to k8-m3 and k8w1 to k8-w3. This is driven by the script k8-arr2.sh and may be customized there.

Each virtual machine depends upon its netplan yaml file to be present in the k8-nodes folder. In future versions, there will be flexibility to specify IP Address ranges and dynamically generate the netplan YAML. Currently (01/2025), the IP addresses are hard coded to 192.168.1.31-33 for K8-m1 to k8-m3, and 192.168.1.41-43 for k8-w1 to k8-w3, with netmask of 192.168.252.0.

### IPv6
The netplan yaml of each virtual machine is available for customiation in k8-nodes directory. By default, the netplan uses token, and IPv6 RA, to configure dual-stack network. Each node has IPv6 configured that follows the suffix of its IPv4. The template uses DHCP for both IPv4 and IPv6. 

## Installation
Copy the scripts suite to a convenient location. E.g. in your home directory, by running the command
> cd && git clone https://github.com/udp1024/vmrun.git

## Operation
When the template is ready and VMrun repo has been cloned to your home directory run the installer script;
> cd vmrun && ./setup-k8.sh

This will start execution of hte script. A series of input prompts will ask you for;
1. The script will identify the SSH key and the operating system it is running under. It assumes VMware type to be Workstation under Linux and Fusion under Mac OS.
2. Path to where you want to locate the cluster; e.g. /data/vms
3. Path for the cluster. Default is k8cluster1 which results in /data/vms/k8cluster1 directory being created. Each node will ahve its own subdirectory in the cluster directory.

For convenience, two scripts start-k8.sh and stop-k8.sh are also available in the vmrun directory to stop and start the cluster.

## Result
At the end of the run, there should be six virtual machines cloned in k8cluster1 folder. Three are intended to be Controllers for the Kubernetes and three as worker nodes. You can now proceed to use kubeadm or other mechanisms to install and configure kubeernetes.

