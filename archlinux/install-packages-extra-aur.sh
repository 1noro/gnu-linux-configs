#!/bin/bash

# intento de instalar los paquetes mencionados en la lista packages-extra.md

# --- instalar desde AUR
## Juegos
# openrct2
git clone https://aur.archlinux.org/openrct2.git; \
cd openrct2; \
makepkg -sri; \
cd ..

## Cryptomonedas
# dogecoin core
# git clone https://aur.archlinux.org/dogecoin-qt.git; \
# cd dogecoin-qt; \
# makepkg -sri; \
# cd ..
# litecoin core
# git clone https://aur.archlinux.org/litecoin-qt.git; \
# cd litecoin-qt; \
# makepkg -sri; \
# cd ..

## Navegadores
# google-chrome
git clone https://aur.archlinux.org/google-chrome.git; \
cd google-chrome; \
makepkg -sri; \
cd ..

## Descargas
# jdownloader
git clone https://aur.archlinux.org/jdownloader2.git; \
cd jdownloader2; \
makepkg -sri; \
cd ..

## Chats y voideoconferencias
# zoom
git clone https://aur.archlinux.org/zoom.git; \
cd zoom; \
makepkg -sri; \
cd ..

## Arreglar PCs
# teamviewer
git clone https://aur.archlinux.org/teamviewer.git; \
cd teamviewer; \
makepkg -sri; \
sudo systemctl enable teamviewerd; \
cd ..

## VPNs
# mullvad
# hay que mirar el PKGBUILD y comprobar que claves se necesitan
# PKGBUILD: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mullvad-vpn
# dónde encontrar las claves: https://mullvad.net/en/help/open-source/
# gía de mullvad para confiar en las claves: https://mullvad.net/en/help/verifying-signatures/
# claves necesarias a dia 202004242239
# EA0A77BF9E115615FC3BD8BC7653B940E494FE87 Linus Färnstrand (code signing key) <linus@mullvad.net>
# 8339C7D2942EB854E3F27CE5AEE9DECFD582E984 David Lönnhager (code signing) <david.l@mullvad.net>
# las descargo a mi pc:
gpg2 --keyserver pool.sks-keyservers.net --recv-keys EA0A77BF9E115615FC3BD8BC7653B940E494FE87
gpg2 --keyserver pool.sks-keyservers.net --recv-keys 8339C7D2942EB854E3F27CE5AEE9DECFD582E984
# las edito:
gpg2 --edit-key EA0A77BF9E115615FC3BD8BC7653B940E494FE87
# > trust
# > 5
# > s
# > q
gpg2 --edit-key 8339C7D2942EB854E3F27CE5AEE9DECFD582E984
# > trust
# > 5
# > s
# > q
# ya hora puedo instalar el paquete
git clone https://aur.archlinux.org/mullvad-vpn.git; \
cd mullvad-vpn; \
makepkg -sri; \
sudo systemctl enable mullvad-daemon; \
cd ..

## Gnome Shell Extensions
# system-monitor
git clone https://aur.archlinux.org/gnome-shell-extension-system-monitor-git.git; \
cd gnome-shell-extension-system-monitor-git; \
makepkg -sri; \
cd ..

## Fuentes
# iosevka (https://typeof.net/Iosevka/)
# fuente monospace preciosa; \
git clone https://aur.archlinux.org/ttf-iosevka.git; \
cd ttf-iosevka; \
makepkg -sri; \
cd ..

# mononoki (https://madmalik.github.io/mononoki/)
# fuente monospace preciosa
git clone https://aur.archlinux.org/ttf-mononoki-git.git; \
cd ttf-mononoki-git; \
makepkg -sri; \
cd ..

# ttf-ms-fonts (https://madmalik.github.io/mononoki/)
# Core TTF Fonts from Microsoft, puede que necesaria para alguna apliación
git clone https://aur.archlinux.org/ttf-ms-fonts.git; \
cd ttf-ms-fonts; \
makepkg -sri; \
cd ..

## GNOME Shell
# flat-remix-gtk (tema)
git clone https://aur.archlinux.org/flat-remix-gtk.git; \
cd flat-remix-gtk; \
makepkg -sri; \
cd ..

# gnome-appfolders-manager (Manage GNOME Shell applications folders.)
git clone https://aur.archlinux.org/gnome-appfolders-manager.git; \
cd gnome-appfolders-manager; \
makepkg -sri; \
cd ..

## Temas Geany
# geany-themes
git clone https://aur.archlinux.org/geany-themes.git; \
cd geany-themes; \
makepkg -sri; \
cd ..
