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
        if [[ $TERM_PROGRAM == "WezTerm" ]]; then
            wez cli set-tab-title $(basename $(pwd))
        fi
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
