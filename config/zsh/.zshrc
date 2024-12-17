# History -- https://github.com/rothgar/mastering-zsh/blob/master/docs/config/history.md
[[ ! -d "$HOME/.cache/zsh" ]] && mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt EXTENDED_HISTORY     # Save command timestamps
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space
setopt SHARE_HISTORY        # Share history between all sessions

# Disable Ctrl-s to freeze terminal
stty stop undef 
# Don't highlight pasted text
zle_highlight=('paste:none')

unsetopt BEEP

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files. 

# Imports
source "$HOME/.zsh/functions.zsh"
source_file "$HOME/.zsh/exports.zsh"
source_file "$HOME/.zsh/prompt.zsh"
source_file "$HOME/.zsh/vim-mode.zsh"
source_file "$HOME/.fzf.zsh"

# Aliases
source_file "$HOME/.zsh/aliases/aliases.zsh"
[[ $(uname -a) == *microsoft* ]] && source_file "$HOME/.zsh/aliases/windows-aliases.zsh"
[[ $(uname -a) == *Ubuntu* ]] && source_file "$HOME/.zsh/aliases/linux-aliases.zsh"
[[ $(uname -s) == "Darwin" ]] && source_file "$HOME/.zsh/aliases/macos-aliases.zsh"
[[ $TERM_PROGRAM == "WezTerm" ]] && source_file "$HOME/.zsh/aliases/wezterm-aliases.zsh"

bindkey -s ^f " fzf-cd-code-projects\n"

# Plugins
plug "Aloxaf/fzf-tab" && zstyle ':fzf-tab:*' fzf-min-height 80
plug "le0me55i/extract"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Remove underline from syntax highlighting
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none 
