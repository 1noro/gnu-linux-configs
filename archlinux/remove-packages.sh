#!/bin/bash
packagelist_install=(
    polari # porque me dió un error en el journal (puede que sin importancia)
    epiphany # el navegador por defecto de gnome que no mola nada
    gnome-documents # no le veo la utildad
    gnome-photos # no le veo la utildad
    gnome-recipes # no le veo la utildad
    totem # reproductor de videos de Gnome, no le veo la utilidad
)

pacman -Rs ${packagelist_install[@]}

# equivalente a apt autoremove:
# pacman -Rs $(pacman -Qtdq)
