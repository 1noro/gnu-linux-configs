#!/bin/bash
# (c) inoro [20200421a]
# [install-from-repositories]

packagelist_install=(
    # utilidades básicas (no gráficas)
    linux-headers
    # zsh
    # zsh-syntax-highlighting
    nano
    # net-tools # deprecated (use: ip addr)
    dnsutils
    tree
    tldr
    htop
    nmap
    neofetch
    git
    jdk11-openjdk
    gnome-tweaks
    papirus-icon-theme

    # utilidades básicas (gráficas)
    simple-scan
    brasero
    gparted
    easytag
    # pyrenamer (buscar sustituto)
    filezilla
    wireshark-qt

    # editores de texto
    gedit
    geany
    geany-plugins
    libreoffice-fresh

    # dependencias
    ### gnome shell system monitor extension dependences
    gtop # (debian) gir1.2-gtop-2.0
    # ¿nm-connection-editor? # (debian) gir1.2-nm-1.0
    clutter # (debian) gir1.2-clutter-1.0

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
    puzzles # https://www.chiark.greenend.org.uk/~sgtatham/puzzles/
    # gplanarity

    # chromium
    chromium

    # astronomía
    stellarium

    # latex
    texlive-most
    texmaker
)

# packagelist_remove=(
#
# )

pacman -Syu
pacman -S --needed ${packagelist_install[@]}
# pacman -R ${packagelist_remove[@]}
