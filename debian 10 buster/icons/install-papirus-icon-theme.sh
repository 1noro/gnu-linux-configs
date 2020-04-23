#!/bin/bash
#RUN AS ROOT
sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu bionic main' > /etc/apt/sources.list.d/papirus-ppa.list"

apt install dirmngr
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
apt update
apt install papirus-icon-theme
