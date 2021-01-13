#!/bin/bash
## by inoro
## RUN AS ROOT

## basic install
apt update; \
apt dist-upgrade -y; \
apt install build-essential linux-headers-$(uname -r) nano net-tools dnsutils tree tldr htop nmap neofetch git curl iperf3 ethtool -y

## RUN ONLY AS ROOT
# echo "pi ALL=(ALL) PASSWD: ALL" > /etc/sudoers.d/010_pi-nopasswd
