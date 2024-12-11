#!/usr/bin/bash

GREEN="\[\e[1;32m\]"
RESET="\[\e[0m\]"
BLUE="\[\e[1;34m\]"
PINK="\[\e[1;38;5;219m\]"

DIR="$BLUE\w$RESET"
BRANCH="$PINK\$(__git_ps1 ' (%s)')$RESET"
ARROW="$GREEN>$RESET"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST="$GREEN\u@\h$RESET:"
    PS1="$HOST$DIR$BRANCH$ "
else
    PS1="$DIR$BRANCH $ARROW "
fi

bind '"\C-h": backward-kill-word' # Ctrl + backspace to delete word
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="[%m-%d-%Y %T] "

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
