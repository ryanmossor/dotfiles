export EDITOR="code"
[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"
[[ -x /usr/bin/batcat ]] && export BAT="/usr/bin/batcat"
[[ -x /usr/local/bin/bat ]] && export BAT="/usr/local/bin/bat"
[[ -x $BAT ]] && alias cat='$BAT --theme=Catppuccin-mocha --paging=never'

if [[ -x /usr/bin/fzf ]]; then
    [[ -x /usr/bin/rg ]] && export FZF_DEFAULT_COMMAND='rg -g "!{**/node_modules/*,**/.git/*}" --files --hidden --ignore'
    export FZF_DEFAULT_OPTS="--reverse --border=rounded \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --preview '$BAT --color=always --theme=Catppuccin-mocha --style=numbers --line-range=:500 {}'"
fi

prependToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

appendToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

[[ ! -d "$HOME/.local/scripts" ]] && mkdir -p "$HOME/.local/scripts"
prependToPath "$HOME/.local/scripts"

parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

setopt PROMPT_SUBST
ARROW="%F{010}>%f"
DIR="%F{004}%~%f"
BRANCH="%F{219}\$(parse_git_branch)%f"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME="%F{010}%n@%m%f:"
    PS1="%B${HOST_NAME}${DIR}${BRANCH}%b$ "
else
    PS1="%B${DIR}${BRANCH} ${ARROW}%b "
fi

alias ls='ls --color=auto'
alias ll='ls -laF'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add commands to history as they are typed, don't wait until shell exit
setopt SHARE_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# Ignore commands beginning with space
setopt HIST_IGNORE_SPACE

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

setopt EXTENDED_HISTORY

# Keep 10000 lines of history within the shell and save it to history
HISTSIZE=10000
SAVEHIST=10000

# Create zsh cache dir if doesn't exist
[[ ! -d "$HOME/.cache/zsh" ]] && mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/history"

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 
fi
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[[._-]]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([[0-9]]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with Ctrl+E:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^R' history-incremental-search-backward

# Plugins
[[ -f "$HOME/.zsh/extract.plugin.zsh" ]] && source "$HOME/.zsh/extract.plugin.zsh"
[[ -f "$HOME/.zsh/zsh-autosuggestions.plugin.zsh" ]] && source "$HOME/.zsh/zsh-autosuggestions.plugin.zsh"
[[ -f "$HOME/.zsh/fzf-hist-search.plugin.zsh" ]] && source "$HOME/.zsh/fzf-hist-search.plugin.zsh"

# Aliases
[[ -f "$HOME/.zsh/aliases.zsh" ]] && source "$HOME/.zsh/aliases.zsh"

if [[ $(uname -a) == *Microsoft* ]]; then
    [[ -f "$HOME/.zsh/windows.aliases.zsh" ]] && source "$HOME/.zsh/windows.aliases.zsh"
    alias aliases='cat $HOME/.zsh/aliases.zsh $HOME/.zsh/windows.aliases.zsh'
elif [[ $(uname -a) == *mint* ]]; then
    [[ -f "$HOME/.zsh/mint.aliases.zsh" ]] && source "$HOME/.zsh/mint.aliases.zsh"
    alias aliases='cat $HOME/.zsh/aliases.zsh $HOME/.zsh/mint.aliases.zsh'
else
    alias aliases='cat $HOME/.zsh/aliases.zsh'
fi
