export EDITOR="vim"
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH

[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"
[[ -x /usr/bin/batcat ]] && export BAT="/usr/bin/batcat"
[[ -x /usr/local/bin/bat ]] && export BAT="/usr/local/bin/bat"

if command -v fdfind &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fdfind --hidden --follow --exclude .git --exclude node_modules'
elif command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude node_modules'
fi

export FZF_DEFAULT_OPTS="--reverse --border=rounded \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_CTRL_R_OPTS="--height=100%"
export FZF_CTRL_T_OPTS="--height=100%"
export FZF_ALT_C_OPTS="--height=100%"

[[ ! -d "$HOME/.cache/zsh" ]] && mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
