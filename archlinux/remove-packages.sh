#!/bin/bash
packagelist_install=(
    polari # porque me dió un error en el journal (puede que sin importancia)
)

pacman -Rs ${packagelist_install[@]}

# equivalente a apt autoremove:
# pacman -Rs $(pacman -Qtdq)
