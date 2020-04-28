#!/bin/bash
for D in */; do
    if [[ $(git -C $D fetch) ]]; then
        git -C $D pull -q
        echo -e "Package  \e[92m\e[1m$D\e[0m needs to be updated."
    else
        echo -e "Package $D no needs to be updated."
    fi
done
