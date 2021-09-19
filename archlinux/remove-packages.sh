#!/bin/bash
packagelist_install=(
    polari # porque me dió un error en el journal (puede que sin importancia)
    epiphany # el navegador por defecto de gnome que no mola nada
    gnome-documents # no le veo la utildad
    gnome-photos # no le veo la utildad
    gnome-recipes # no le veo la utildad
    gnome-builder # bloated
    gnome-boxes # no lo uso
    totem # reproductor de videos de Gnome, no le veo la utilidad
    eog # si es sustituido por sxiv
)

pacman -Rns ${packagelist_install[@]}
# n: borra archivos de configuración

# equivalente a apt autoremove:
# pacman -Rns $(pacman -Qtdq)
