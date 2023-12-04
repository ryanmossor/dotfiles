export WIN_HOME="/mnt/c/Users/$USER"
export APPDATA="$WIN_HOME/Roaming/AppData"
wsl_git_path=$(type -p git | awk '{print $NF}')

alias bp='dot --windows && source ~/.zshrc && echo "~/.zshrc reloaded"'

alias vs="/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Professional/Common7/IDE/devenv.exe"

alias screenkey='$WIN_HOME/code/KeyCastOW/build/keycastow.exe &'
alias gt='$wsl_git_path team'
alias gtc='$wsl_git_path commit'
alias work='cd $WIN_HOME/code/work'
