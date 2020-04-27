#!/bin/bash
# (c) inoro [20190920a]
# [install-from-repositories]

packagelist_install=(
    # utilidades básicas (no gráficas)
    firmware-misc-nonfree
    lm-sensors
    build-essential
    linux-headers-$(uname -r)
    zsh
    zsh-syntax-highlighting
    nano
    net-tools
    dnsutils
    tree
    tldr
    htop
    nmap
    neofetch
    git
    openjdk-11-jdk
    papirus-icon-theme

    # utilidades básicas (gráficas)
    simple-scan
    brasero
    gparted
    easytag
    #pyrenamer
    filezilla
    wireshark

    # editores de texto
    gedit
    geany
    libreoffice

    # dependencias
    ### gnome shell system monitor extension dependences
    gir1.2-gtop-2.0
    gir1.2-nm-1.0
    gir1.2-clutter-1.0

    # reproductores de vídeo y audio
    vlc
    rhythmbox

    # cliente bittorrent
    qbittorrent

    # pdf
    evince
    okular
    xournal

    # procesamiento de imágenes
    gimp
    inkscape

    # procesamiento de audio
    audacity

    # editor de diagramas
    dia

    # editor 2D
    librecad

    # games (https://blends.debian.org/games/tasks/puzzle)
    gnome-mahjongg
    sgt-puzzles #https://www.chiark.greenend.org.uk/~sgtatham/puzzles/
    gplanarity

    # chromium
    chromium

    # astronomía
    stellarium

    # latex
    texlive-full
    texmaker
)

packagelist_remove=(
    transmission-gtk
    shotwell
)

apt update
apt upgrade -y
apt install ${packagelist_install[@]} -y
apt remove ${packagelist_remove[@]}
apt autoremove
