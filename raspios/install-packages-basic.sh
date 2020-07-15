#!/bin/bash
## by inoro
## RUN AS ROOT

## basic install
apt update; \
apt upgrade -y; \
apt install nano net-tools dnsutils tree tldr htop nmap neofetch git curl iperf3 ethtool -y

## RUN ONLY AS ROOT
# echo "pi ALL=(ALL) PASSWD: ALL" > /etc/sudoers.d/010_pi-nopasswd
