zsh_dir="$HOME/.zsh"

function source_file() {
    [[ -f "$1" ]] && source "$1"
}

function plug() {
    plugin_name=$(echo "$1" | cut -d "/" -f 2)
    if [[ -d "$zsh_dir/plugins/$plugin_name" ]]; then 
        source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.plugin.zsh" || \
        source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.zsh"
    else
        git clone "https://github.com/$1.git" "$zsh_dir/plugins/$plugin_name"
        source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.plugin.zsh" || \
        source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.zsh"
    fi
}

function add_completion() {
    plugin_name=$(echo "$1" | cut -d "/" -f 2)
    if [[ -d "$zsh_dir/plugins/$plugin_name" ]]; then 
		completion_file_path=$(ls "$zsh_dir/plugins/$plugin_name/_*")
		fpath+="$(dirname "${completion_file_path}")"
        source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$zsh_dir/plugins/$plugin_name"
		fpath+=$(ls "$zsh_dir/plugins/$plugin_name/_*")
        [[ -f $zsh_dir/.zccompdump ]] && "$zsh_dir/.zccompdump"
    fi
	completion_file="$(basename "${completion_file_path}")"
	[[ "$2" = true ]] && compinit "${completion_file:1}"
} 

function update() {
    [[ $(uname -a) == *Ubuntu* ]] && sudo apt update && sudo apt upgrade -y
    [[ $(uname -a) == *mint* ]] && flatpak update -y
    [[ $(uname -s) == "Darwin" ]] && brew update && brew upgrade

    # update fzf
    pushd ~/.fzf > /dev/null &&
    git pull &&
    ./install --key-bindings --completion --no-update-rc &&
    popd > /dev/null

    # update neovim
    [ ! -d ~/code/neovim ] && git clone https://github.com/neovim/neovim.git --branch=stable ~/code/neovim
    pushd ~/code/neovim > /dev/null || exit
    git checkout stable && git pull
    make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install 
    popd > /dev/null || exit
}

function fzf-cd-code-projects() {
    local dirs=(
        "$HOME/code"
        "$HOME/code/work"
        "$WIN_HOME/code"
        "$WIN_HOME/code/work"
        "$WIN_HOME/code/work/candidates"
    )

    local selected=$(fd . "${dirs[@]}" --exact-depth 1 -t d &> /dev/null | fzf)

    if [[ -n "$selected" ]]; then
        cd "$selected"
        [[ $TERM_PROGRAM == "WezTerm" ]] && wez cli set-tab-title $(basename $(pwd))
    fi
}

function setdiff() {
    if [ ! -f /tmp/before.txt ]; then
        adb shell settings list global > /tmp/before.txt
        adb shell settings list secure >> /tmp/before.txt
        adb shell settings list system >> /tmp/before.txt
        adb shell settings list --lineage global >> /tmp/before.txt
        adb shell settings list --lineage secure >> /tmp/before.txt
        adb shell settings list --lineage system >> /tmp/before.txt

        echo "Current settings written to /tmp/before.txt"
    else
        adb shell settings list global > /tmp/after.txt
        adb shell settings list secure >> /tmp/after.txt
        adb shell settings list system >> /tmp/after.txt
        adb shell settings list --lineage global >> /tmp/after.txt
        adb shell settings list --lineage secure >> /tmp/after.txt
        adb shell settings list --lineage system >> /tmp/after.txt

        diff --color /tmp/before.txt /tmp/after.txt
        rm /tmp/before.txt /tmp/after.txt
    fi
}
