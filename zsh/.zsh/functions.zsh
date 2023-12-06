ZSH_DIR="$HOME/.zsh"

function source_file() {
    [[ -f "$1" ]] && source "$1"
}

function plug() {
    PLUGIN_NAME=$(echo "$1" | cut -d "/" -f 2)
    if [[ -d "$ZSH_DIR/plugins/$PLUGIN_NAME" ]]; then 
        source_file "$ZSH_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source_file "$ZSH_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZSH_DIR/plugins/$PLUGIN_NAME"
        source_file "$ZSH_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source_file "$ZSH_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    fi
}

function add_completion() {
    PLUGIN_NAME=$(echo "$1" | cut -d "/" -f 2)
    if [[ -d "$ZSH_DIR/plugins/$PLUGIN_NAME" ]]; then 
		completion_file_path=$(ls "$ZSH_DIR/plugins/$PLUGIN_NAME/_*")
		fpath+="$(dirname "${completion_file_path}")"
        source_file "$ZSH_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZSH_DIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls "$ZSH_DIR/plugins/$PLUGIN_NAME/_*")
        [[ -f $ZSH_DIR/.zccompdump ]] && "$ZSH_DIR/.zccompdump"
    fi
	completion_file="$(basename "${completion_file_path}")"
	[[ "$2" = true ]] && compinit "${completion_file:1}"
} 
