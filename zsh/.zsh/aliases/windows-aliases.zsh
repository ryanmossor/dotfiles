export WIN_HOME="/mnt/c/Users/$USER"
export APPDATA="$WIN_HOME/Roaming/AppData"
wsl_git_path=$(type -p git | awk '{print $NF}')

alias bp='dot --windows && source ~/.zshrc && echo "~/.zshrc reloaded"'

alias vs="/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Professional/Common7/IDE/devenv.exe"

alias keys='$WIN_HOME/code/KeyCastOW/build/keycastow.exe &'
alias gt='$wsl_git_path team'
alias gtc='$wsl_git_path commit'
alias work='cd $WIN_HOME/code/work'

# WIP - VS errors when opening .sln file
#alias fzw='find "$(find $WIN_HOME/code/work -maxdepth 1 -mindepth 1 -type d | fzf)" -maxdepth 1 -type f -name "*.sln" | xargs -ro /mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Professional/Common7/IDE/devenv.exe'

alias fzc='selected_dir=$(find "$HOME/code" "$HOME/code/work" "$WIN_HOME/code" "$WIN_HOME/code/work" "$WIN_HOME/code/work/candidates" -maxdepth 1 -mindepth 1 -type d &> /dev/null | fzf); [ -n "$selected_dir" ] && cd "$selected_dir"'
