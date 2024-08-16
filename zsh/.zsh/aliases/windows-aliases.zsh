export WIN_HOME="/mnt/c/Users/$USER"
export APPDATA="$WIN_HOME/Roaming/AppData"
wsl_git_path=$(type -p git | awk '{print $NF}')

alias vs="/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Professional/Common7/IDE/devenv.exe"
alias keys='$WIN_HOME/code/KeyCastOW/build/keycastow.exe &'

alias bp='dot --windows && source ~/.zshrc && echo "~/.zshrc reloaded"'
alias gt='$wsl_git_path team'
alias gtc='$wsl_git_path commit'
alias work='cd $WIN_HOME/code/work'

# fzf search for .sln files in current dir
alias fzs='selected=$(fd . -t file -e sln | fzf); [[ -n "$selected" ]] && vs "$selected" &; cd $(dirname "$selected")'

git() {
    if [[ "$(pwd)" == *oversight* ]]; then
        git.exe "$@"
    else
        $(type -p git | cut -d " " -f 3) "$@"
    fi
}
