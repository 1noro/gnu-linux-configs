#!/bin/bash
# inspiración:
# git add .; git commit -m "E$(date '+%Y%m%d%H%M%S')::${PWD##*/}"; git push
for D in */; do
    echo -e "# DIRECTORY: \e[92m\e[1m$D\e[0m"
    #git -C $D pull -q # -q de Quiet
    git -C $D add .
    git -C $D commit -m "Sincronización rápida $(date '+%Y%m%d%H%M%S')::$D" > /dev/null
    git -C $D push
    echo ""
done
echo -e "# END"
