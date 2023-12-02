alias history='history -f 1'
alias x=extract
alias xsc='xclip -selection clipboard'
alias clip='xclip -selection clipboard'

alias cgc='cat ~/.gitconfig'
alias gp='git push origin HEAD'

alias bp='source ~/.zshrc'
alias cbp='cat ~/.zshrc'
alias ebp='$EDITOR ~/.zshrc'

alias cvrc='cat ~/.vimrc'
alias evrc='$EDITOR ~/.vimrc'

alias hosts='cat ~/.ssh/config'

fe() { fzf | xargs -ro $EDITOR }
fv() { fzf | xargs -ro vim }
fx() { fzf | xargs realpath | tr '\n' ' ' | xclip -selection clipboard }

clear_git_branches() { git branch | grep -vE "main|master|DEV" | xargs git branch -D }
