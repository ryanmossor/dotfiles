export EDITOR="nvim"
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH
export DOTNET_CLI_TELEMETRY_OPTOUT=1

[[ -z $DOTFILES ]] && export DOTFILES="$HOME/dotfiles"
[[ -x /usr/bin/batcat ]] && export BAT="/usr/bin/batcat"
[[ -x /usr/local/bin/bat ]] && export BAT="/usr/local/bin/bat"
[[ -x /usr/local/go/bin ]] && export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

if command -v fdfind &> /dev/null; then
    export FD='fdfind'
elif command -v fd &> /dev/null; then
    export FD='fd'
fi

export FZF_DEFAULT_COMMAND="$FD --hidden --follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--highlight-line --reverse --border=rounded --info=inline-right --marker ▏ --pointer ▌ \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_CTRL_R_OPTS="--height=100%"
export FZF_CTRL_T_OPTS="--height=100%"
export FZF_ALT_C_OPTS="--height=100%"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
