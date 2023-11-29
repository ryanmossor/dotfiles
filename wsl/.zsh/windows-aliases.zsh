# TODO: make WSL username same as windows host username so can use $USER in $WIN_HOME
# export WIN_HOME="/mnt/c/Users/$USER"
# export APPDATA="/path/to/AppData"
wsl_git_path=$(type -p git | awk '{print $NF}')

#alias git="/path/to/git.exe"
#alias vs="/path/to/VisualStudio.exe"

alias screenkey='$WIN_HOME/code/KeyCastOW/build/keycastow.exe &'
alias gt='$wsl_git_path team'
alias gtc='$wsl_git_path commit'
alias work='$WIN_HOME/work'

dot() {
    pushd $DOTFILES
    git ff
    ./stow.sh --windows
    popd
}
