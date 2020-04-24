#!/bin/bash

# intento de instalar los paquetes mencionados en la lista packages-extra.md

# --- instalar desde AUR
## Juegos
# openrct2
git clone https://aur.archlinux.org/openrct2.git
cd openrct2
makepkg -sri
cd ..

## Navegadores
# google-chrome
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -sri
cd ..

## Descargas
# jdownloader
git clone https://aur.archlinux.org/jdownloader2.git
cd jdownloader2
makepkg -sri
cd ..

## Chats y voideoconferencias
# zoom
git clone https://aur.archlinux.org/zoom.git
cd zoom
makepkg -sri
cd ..
