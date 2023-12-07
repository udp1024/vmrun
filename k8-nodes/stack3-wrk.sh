#!/bin/bash
# script to join the kubernetes cluster
sudo kubeadm join k8-m1.udp1024.com:6443 --token ubifku.2x940i5b1h6nfflf \
	--discovery-token-ca-cert-hash sha256:0d24b9126b53deb0b71f0c4ee4ebfa11dc88ce03c7d4615b589c014a058a37ed


