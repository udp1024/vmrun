#!/bin/bash

# Store the output of the vmrun list command in a variable
vm_list=$(vmrun list)

# Read the output line by line
echo "$vm_list" | while read -r line; do
    # Skip the first line
    if [[ "$line" == "Total running VMs:"* ]]; then
        continue
    fi

    # Run the vmrun getGuestIPAddress command for each VM
    NODEIP=$(vmrun getGuestIPAddress "$line" wait)
    echo "$line" has IP $NODEIP
done

