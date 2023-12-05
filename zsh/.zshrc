# Add commands to history as they are typed, don't wait until shell exit
setopt SHARE_HISTORY
# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS
# Ignore commands beginning with space
setopt HIST_IGNORE_SPACE
# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS
# Save each command's timestamp
setopt EXTENDED_HISTORY

# Disable Ctrl-s to freeze terminal
stty stop undef 
# Don't highlight pasted text
zle_highlight=('paste:none')

unsetopt BEEP

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files. 

source "$HOME/.zsh/functions.zsh"
source_file "exports.zsh"
source_file "prompt.zsh"
source_file "vim-mode.zsh"

# Aliases
source_file "aliases/aliases.zsh"

if [[ $(uname -a) == *microsoft* ]]; then
    source_file "aliases/windows-aliases.zsh"
elif [[ $(uname -a) == *mint* ]]; then
    source_file "aliases/mint-aliases.zsh"
fi

# Plugins
plug "Aloxaf/fzf-tab" && zstyle ':fzf-tab:*' fzf-min-height 80
plug "joshskidmore/zsh-fzf-history-search"
plug "le0me55i/extract"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Remove underline from syntax highlighting
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none 
