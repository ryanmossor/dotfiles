bindkey -v
export KEYTIMEOUT=1

# Ctrl-e to edit current command in editor
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Change cursor shape for different vi modes.
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

function _set_block_cursor() { _set_cursor '\e[2 q' }
function _set_beam_cursor() { _set_cursor '\e[5 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      _set_block_cursor
  else
      _set_beam_cursor
  fi
}
zle -N zle-keymap-select
# ensure beam cursor when starting new terminal
precmd_functions+=(_set_beam_cursor)
# ensure insert mode and beam cursor when exiting vim
zle-line-init() { zle -K viins; _set_beam_cursor }
zle-line-finish() { _set_block_cursor }
zle -N zle-line-finish 
