#!/bin/bash

# intento de instalar los paquetes mencionados en la lista packages-extra.md

# --- instalación desde los repositorios oficiales de Arch Linux
packagelist_install=(
    ## Edtitores de código e IDEs
    atom
    # code # visual studio code (no instalar hasta comprobar si es bueno)
    dbeaver
    eclipse-java

    ## Juegos
    steam # check diference between steam-native-runtime
    # mgba-sdl
    0ad
    openttd
    openra

    ## Navegadores
    firefox-developer-edition

    ## Chats y voideoconferencias
    telegram-desktop
    discord

    ## Máquinas virtuales
    virtualbox

    ## Emular Windows (necesitas habilitar el repositorio multilib en pacman.conf)
    wine
    winetricks

    # Conectar con Android (dispositivos móviles)
    kdeconnect
)

pacman -Syu
pacman -S --needed ${packagelist_install[@]}
