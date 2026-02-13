alias bp='dot --personal && source ~/.zshrc && echo "~/.zshrc reloaded"'

alias scl='sudo crontab -l'
alias sce='sudo crontab -e'

alias wiiu='sudo wii-u-gc-adapter'

alias cursor='sudo update-alternatives --config x-cursor-theme'

class() {
    echo 'Click a window'
    xprop | grep WM_CLASS | awk '{ print $4 }'
}

scratch() {
    if ! pgrep -f "wezterm.*scratch_nvim" >/dev/null; then
        wezterm start --class "scratch_nvim" nvim ~/scratch.txt & disown
    fi
}
