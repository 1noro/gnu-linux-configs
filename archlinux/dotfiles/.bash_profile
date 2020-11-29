#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export GPG_TTY=$(tty)

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
