#!/bin/bash

cd k8-nodes
for f in {1..3}; do cp netplan.txt netplan.m$f; done
for f in {1..3}; do cp netplan.txt netplan.w$f; done
for f in {1..3}; do cp node.sh m$f.sh; done
for f in {1..3}; do cp node.sh w$f.sh; done
find . -type f -iname "*.sh" -exec chmod +x {} \;

