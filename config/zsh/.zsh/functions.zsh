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

function set_tab_title() {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$*"
    elif [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
        wez cli set-tab-title "$*"
    elif [[ "$TERM_PROGRAM" == "ghostty" ]]; then
        printf "\e]2;$*"
    fi
}

function t() {
    if [[ -z "$1" ]]; then
        if [[ $(pwd) == $HOME ]]; then
            set_tab_title "home"
        else
            set_tab_title "$(basename $(pwd))"
        fi
    else
        set_tab_title "$*"
    fi
}

# title first word
function tfw() {
    set_tab_title "$(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $1}')"
}

# title last word
function tlw() {
    set_tab_title "$(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $NF}')"
}

# title working dir
function twd() {
    set_tab_title "$(basename $(pwd))"
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
        set_tab_title $(basename $(pwd))
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

# Open neovim + terminal in current dir
function nt() {
  local current_dir=$(pwd)
  local editor_pane ai_pane
  local ai="$1"

  # Get current pane ID (will become editor pane after splits)
  editor_pane=$(tmux display-message -p '#{pane_id}')

  # Split window vertically - top 80%, bottom 20%
  tmux split-window -v -p 20 -c "$current_dir"

  # Go back to top pane (editor_pane) and split it horizontally
  if [ -n "$ai" ] && command -v "$ai"; then
      tmux select-pane -t "$editor_pane"
      tmux split-window -h -p 30 -c "$current_dir"

      # After horizontal split, cursor is in the right pane (new pane)
      # Get its ID and run ai there
      ai_pane=$(tmux display-message -p '#{pane_id}')
      tmux send-keys -t "$ai_pane" "$ai" C-m
  fi

  # Run nvim in the left pane
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

  # Select the nvim pane for focus
  tmux select-pane -t "$editor_pane"
}

# Open neovim, terminal, and AI (opencode)
function nta() {
    nt opencode
}

function s() {
    if [ -n "$TMUX" ] && [ $# -gt 0 ]; then
        tmux rename-session "$*"
    fi
}

function sln() {
    if command -v rider; then
        rider *.sln
    fi
}
