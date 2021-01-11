#!/bin/bash
for D in */; do
    echo -e "# DIRECTORY: \e[92m\e[1m$D\e[0m"
    #git -C $D pull -q # -q de Quiet
    git -C $D fetch
    git -C $D pull
    echo ""
done
echo -e "# END"
