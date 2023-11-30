alias scl='sudo crontab -l'
alias sce='sudo crontab -e'

alias wiiu='sudo wii-u-gc-adapter'

alias taskerbuild='./scripts/build.sh'
alias testbuild='./scripts/build.sh --run-tests'
alias update_all='sudo /home/$USER/code/Scripts/update_all.sh'

alias audiofix='pulseaudio -k'
alias cursor='sudo update-alternatives --config x-cursor-theme'

dot() {
    pushd $DOTFILES
    git ff
    ./stow.sh --personal
    popd
}
