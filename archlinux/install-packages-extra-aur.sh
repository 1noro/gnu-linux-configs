#!/bin/bash

# intento de instalar los paquetes mencionados en la lista packages-extra.md

# --- instalar desde AUR
## Juegos
# openrct2-git
git clone https://aur.archlinux.org/packages/openrct2-git; \
cd openrct2-git; \
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
# git clone https://aur.archlinux.org/zoom.git; \
# cd zoom; \
# makepkg -sri; \
# cd ..

## Arreglar PCs
# teamviewer
# git clone https://aur.archlinux.org/teamviewer.git; \
# cd teamviewer; \
# makepkg -sri; \
# sudo systemctl enable teamviewerd; \
# cd ..

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
# git clone https://aur.archlinux.org/gnome-shell-extension-system-monitor-git.git; \
# cd gnome-shell-extension-system-monitor-git; \
# makepkg -sri; \
# cd ..

# bubblemail
# git clone https://aur.archlinux.org/bubblemail.git; \
# cd bubblemail; \
# makepkg -sri; \
# cd ..; \
# git clone https://aur.archlinux.org/bubblemail-gnome-shell.git; \
# cd bubblemail-gnome-shell; \
# makepkg -sri; \
# cd ..

## Fuentes
# iosevka (https://typeof.net/Iosevka/)
# fuente monospace preciosa; \
# git clone https://aur.archlinux.org/ttf-iosevka.git; \
# cd ttf-iosevka; \
# makepkg -sri; \
# cd ..

# mononoki (https://madmalik.github.io/mononoki/)
# fuente monospace preciosa
# git clone https://aur.archlinux.org/ttf-mononoki-git.git; \
# cd ttf-mononoki-git; \
# makepkg -sri; \
# cd ..

# ttf-ms-fonts (https://madmalik.github.io/mononoki/)
# Core TTF Fonts from Microsoft, puede que necesaria para alguna apliación
git clone https://aur.archlinux.org/ttf-ms-fonts.git; \
cd ttf-ms-fonts; \
makepkg -sri; \
cd ..

# open-dyslexic-fonts (https://opendyslexic.org/)
git clone https://aur.archlinux.org/open-dyslexic-fonts.git; \
cd open-dyslexic-fonts; \
makepkg -sri; \
cd ..

# adobe-base-14-fonts (Courier, Helvetica, Times, Symbol, ZapfDingbats with Type1)
git clone https://aur.archlinux.org/adobe-base-14-fonts.git; \
cd adobe-base-14-fonts; \
makepkg -sri; \
cd ..

## GNOME Shell
# flat-remix-gtk (tema)
# git clone https://aur.archlinux.org/flat-remix-gtk.git; \
# cd flat-remix-gtk; \
# makepkg -sri; \
# cd ..

## Temas Geany
# geany-themes
# git clone https://aur.archlinux.org/geany-themes.git; \
# cd geany-themes; \
# makepkg -sri; \
# cd ..

## Correo electrónico
# protonmail-bridge (se necesita una cuenta de pago)
# git clone https://aur.archlinux.org/protonmail-bridge.git; \
# cd protonmail-bridge; \
# makepkg -sri; \
# cd ..

## Minecraft rcon clinet
# mcrcon
# git clone https://aur.archlinux.org/mcrcon.git; \
# cd mcrcon; \
# makepkg -sri; \
# cd ..

## Autofirma
# autofirma
# git clone https://aur.archlinux.org/autofirma.git; \
# cd autofirma; \
# makepkg -sri; \
# cd ..

## Packet Tracer
# packettracer
# necesitas el deb de la versión mas actualizada del packet tracer
# descargado desde: https://www.netacad.com/portal/resources/packet-tracer
# git clone https://aur.archlinux.org/packettracer.git; \
# cd packettracer; \
# makepkg -sri; \
# cd ..

## Speedtest by Ookla
# speedtest
# git clone https://aur.archlinux.org/ookla-speedtest-bin.git; \
# cd ookla-speedtest-bin; \
# makepkg -sri; \
# cd ..

## Visualk Studio Code (Microsoft Branded)
# (para poder usar Live Share)
# visual-studio-code-bin
git clone https://aur.archlinux.org/visual-studio-code-bin.git; \
cd visual-studio-code-bin; \
makepkg -sri; \
cd ..

## NewsFlash, The spiritual successor to FeedReader
# newsflash-git
# git clone https://aur.archlinux.org/newsflash-git.git; \
# cd newsflash-git; \
# makepkg -sri; \
# cd ..

## Android Studio: The official Android IDE (Stable branch)
# android-studio
# git clone https://aur.archlinux.org/android-studio.git; \
# cd android-studio; \
# makepkg -sri; \
# cd ..
## PARA REINSTALAR BORRAR TODAS LAS CARPETAS "android", "Google" y "gradle" QUE HAY EN TU $HOME
## ACEPTAR LICENCIAS
## https://stackoverflow.com/questions/54273412/failed-to-install-the-following-android-sdk-packages-as-some-licences-have-not/59981986?newreg=6ef286d40c8543e99181e0db7d0bfdb8
## INSTALA "Android SDK Command-line Tools" DESDE EL SDK MANAGER (interfaz gráfica)
## export JAVA_HOME=/opt/android-studio/jre/
## yes | ~/Android/Sdk/tools/bin/sdkmanager --licenses

## Godot
# godot
# git clone https://aur.archlinux.org/godot.git; \
# cd godot; \
# makepkg -sri; \
# cd ..

## mahjong (https://mahjong.julianbradfield.org/)
# mahjong
# git clone https://aur.archlinux.org/mahjong.git; \
# cd mahjong; \
# makepkg -sri; \
# cd ..

## nut-monitor (https://wiki.archlinux.org/index.php/Network_UPS_Tools#NUT-Monitor)
# nut-monitor (pygtk es una dependencia y parece que no es tan facil instalarla)
# git clone https://aur.archlinux.org/nut-monitor.git; \
# cd nut-monitor; \
# makepkg -sri; \
# cd ..
# DESINSTALAR: sudo pacman -Rns nut-monitor

## rdfind (https://rdfind.pauldreik.se/)
# Redundant data find - a program that finds duplicate files.
# rdfind
git clone https://aur.archlinux.org/rdfind.git; \
gpg --keyserver keyserver.ubuntu.com --search-keys 5C4A26CD4CC8C397 \
cd rdfind; \
makepkg -sri; \
cd ..

## lyrebird (https://github.com/lyrebird-voice-changer/lyrebird)
# Simple and powerful voice changer for Linux, written in GTK 3
# lyrebird
# git clone https://aur.archlinux.org/lyrebird.git; \
# cd lyrebird; \
# makepkg -sri; \
# cd ..

## cgoban3 (https://gokgs.com)
# A KGS client and SGF editor (edit Go scenarios)
# cgoban3
git clone https://aur.archlinux.org/cgoban3.git; \
cd cgoban3; \
makepkg -sri; \
cd ..

## Microsoft Teams
# teams
# git clone https://aur.archlinux.org/teams.git; \
# cd teams; \
# makepkg -sri; \
# cd ..
