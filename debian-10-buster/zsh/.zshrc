# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors
#~ PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#~ PS1="%B[%{$fg[green]%}%n%{$reset_color%}@%B%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$reset_color%}]$%b "
if [[ "$USERNAME" == 'root' ]]; then
	PS1="%B%{$fg[white]%}[%{$fg[red]%}%n%{$fg[white]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[white]%}]%{$fg[red]%}#%{$reset_color%}%b "
else
	PS1="%B%{$fg[white]%}[%{$fg[green]%}%n%{$fg[white]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[white]%}]$%{$reset_color%}%b "
fi

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histfile

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# Use lf to switch directories and bind it to ctrl-o
#~ lfcd () {
    #~ tmp="$(mktemp)"
    #~ lf -last-dir-path="$tmp" "$@"
    #~ if [ -f "$tmp" ]; then
        #~ dir="$(cat "$tmp")"
        #~ rm -f "$tmp"
        #~ [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    #~ fi
#~ }
#~ bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
#~ autoload edit-command-line; zle -N edit-command-line
#~ bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
#~ [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
#~ [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
# apt install zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#add by inoro
#setopt beep
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

