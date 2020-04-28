#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;33m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;201m\]\W\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"

#complete -c man which
complete -cf sudo

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# --- Check for updates
FLAG="/tmp/check_updates.flag"
if [ ! -f $FLAG ]; then
    echo "sudo pacman -Sy; pacman -Qu" >> ~/.bash_history
    # echo "sudo pacman -Syu" >> ~/.bash_history
    echo -e "\e[92m\e[1m¿Hay actualizaciones pendientes?\e[0m"
    echo -e " 1. Ejecuta '\e[5msudo pacman -Sy; pacman -Qu\e[0m' (en el historial)."
    # echo -e " 1. Ejecuta 'sudo pacman -Syu' (en el historial)."
    echo -e " 2. Visita www.archlinux.org y bbs.archlinux.org."
    echo -e " 3. Comprueba que no hay conflictos con dichos paquetes."
    echo -e " 4. Asegúrate de tener tiempo para solucionar posibles errores."
    echo -e " 5. Instala las actualizaciones."
    touch $FLAG
fi

# para que steam no se minimice en el 'tray' inexistente de Gnome Shell y se
# cierre completamente al pulsar X
# (parece que no funciona)
#STEAM_FRAME_FORCE_CLOSE=1
#export STEAM_FRAME_FORCE_CLOSE=1
