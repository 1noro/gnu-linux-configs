#!/bin/bash
## by inoro
## RUN AS ROOT

## basic install
apt update; \
apt upgrade -y; \
apt install nano net-tools dnsutils tree tldr htop nmap neofetch git curl -y
