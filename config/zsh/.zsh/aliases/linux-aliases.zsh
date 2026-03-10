alias bp='dot --linux && source ~/.zshrc && echo "~/.zshrc reloaded"'

alias scl='sudo crontab -l'
alias sce='sudo crontab -e'

alias wiiu='sudo wii-u-gc-adapter'

alias cursor='sudo update-alternatives --config x-cursor-theme'

class() {
    echo 'Click a window'
    xprop | grep WM_CLASS | awk '{ print $4 }'
}

scratch() {
    if ! pgrep -f "i3.scratch" >/dev/null; then
        if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
            wezterm start --class "i3.scratch" nvim ~/scratch.txt & disown
        elif [[ "$TERM_PROGRAM" == "ghostty" ]]; then
            ghostty --class=i3.scratch -e nvim ~/scratch.txt & disown
        fi
    fi
}

# opencode
export PATH=/home/ryan/.opencode/bin:$PATH
