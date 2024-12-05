alias bp='dot --personal && source ~/.zshrc && echo "~/.zshrc reloaded"'

alias scl='sudo crontab -l'
alias sce='sudo crontab -e'

alias wiiu='sudo wii-u-gc-adapter'

alias audiofix='pulseaudio -k'
alias cursor='sudo update-alternatives --config x-cursor-theme'

class() {
    echo 'Click a window'
    xprop | grep WM_CLASS | awk '{ print $4 }'
}
