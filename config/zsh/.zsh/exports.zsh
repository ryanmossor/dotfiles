export EDITOR="nvim"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANWIDTH=999
export DOTNET_CLI_TELEMETRY_OPTOUT=1

[ -z "$DOTFILES" ] && export DOTFILES="$HOME/dotfiles"

prepend_path "$HOME/.local/bin"
prepend_path "$HOME/.local/scripts"

append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

prepend_path "$HOME/.dotnet/tools"
prepend_path "$HOME/.aspire/bin"

prepend_path "$HOME/.opencode/bin"

if command -v fdfind &> /dev/null; then
    export FD='fdfind'
elif command -v fd &> /dev/null; then
    export FD='fd'
fi

export FZF_DEFAULT_COMMAND="$FD --hidden --follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--highlight-line \
    --reverse \
    --cycle \
    --border=rounded \
    --info=inline-right \
    --marker ▏ \
    --pointer ▌ \
    --color=bg+:#313244,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#CBA6F7,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"

# export FZF_CTRL_R_OPTS="--height=100%"
# export FZF_CTRL_T_OPTS="--height=100%"
# export FZF_ALT_C_OPTS="--height=100%"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="" # Disable fzf Alt+C so tmux can use as copy mode keybind

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Force this since ghostty has rendering issues over SSH otherwise
export TERM=xterm-256color
