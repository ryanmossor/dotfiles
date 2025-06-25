zsh_dir="$HOME/.zsh"

function have {
  command -v "$1" &> /dev/null
}

function github_latest_tag() {
    local repo="$1"
    curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' | sed 's/v//'
}

function source_file() {
    [[ -f "$1" ]] && source "$1"
}

function plug() {
    plugin_name=$(echo "$1" | cut -d "/" -f 2)
    if [[ ! -d "$zsh_dir/plugins/$plugin_name" ]]; then
        git clone "https://github.com/$1.git" "$zsh_dir/plugins/$plugin_name"
    fi

    source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.plugin.zsh" || \
    source_file "$zsh_dir/plugins/$plugin_name/$plugin_name.zsh"
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

    local expanded_dirs=$(fd . "${dirs[@]}" --exact-depth 1 -t d 2> /dev/null)
    expanded_dirs+="\n$DOTFILES"
    local selected=$(echo "$expanded_dirs" | fzf)

    if [ -n "$selected" ]; then
        cd "$selected"
        [[ $TERM_PROGRAM == "WezTerm" ]] && wez cli set-tab-title $(basename $(pwd))
        clear
    fi
}

function setdiff() {
    if [ ! -f /tmp/before.txt ]; then
        echo -e "===== GLOBAL =====\n" > /tmp/before.txt
        adb shell settings list global >> /tmp/before.txt
        echo -e "\n===== SECURE =====\n" >> /tmp/before.txt
        adb shell settings list secure >> /tmp/before.txt
        echo -e "\n===== SYSTEM =====\n" >> /tmp/before.txt
        adb shell settings list system >> /tmp/before.txt
        echo -e "\n===== LINEAGE GLOBAL =====\n" >> /tmp/before.txt
        adb shell settings list --lineage global >> /tmp/before.txt
        echo -e "\n===== LINEAGE SECURE =====\n" >> /tmp/before.txt
        adb shell settings list --lineage secure >> /tmp/before.txt
        echo -e "\n===== LINEAGE SYSTEM =====\n" >> /tmp/before.txt
        adb shell settings list --lineage system >> /tmp/before.txt

        echo "Current settings written to /tmp/before.txt"
    else
        echo -e "===== GLOBAL =====\n" > /tmp/after.txt
        adb shell settings list global >> /tmp/after.txt
        echo -e "\n===== SECURE =====\n" >> /tmp/after.txt
        adb shell settings list secure >> /tmp/after.txt
        echo -e "\n===== SYSTEM =====\n" >> /tmp/after.txt
        adb shell settings list system >> /tmp/after.txt
        echo -e "\n===== LINEAGE GLOBAL =====\n" >> /tmp/after.txt
        adb shell settings list --lineage global >> /tmp/after.txt
        echo -e "\n===== LINEAGE SECURE =====\n" >> /tmp/after.txt
        adb shell settings list --lineage secure >> /tmp/after.txt
        echo -e "\n===== LINEAGE SYSTEM =====\n" >> /tmp/after.txt
        adb shell settings list --lineage system >> /tmp/after.txt

        diff --color /tmp/before.txt /tmp/after.txt
        rm /tmp/before.txt /tmp/after.txt
    fi
}
