[[ -x /usr/bin/batcat ]] && alias cat='batcat --theme=Catppuccin-mocha --paging=never'
alias history='history -f 1'
alias x=extract
alias xsc='xclip -selection clipboard'

alias cgc='cat ~/.gitconfig'
alias gp='git push origin HEAD'

alias bp='source ~/.zshrc'
alias cbp='cat ~/.zshrc'
alias ebp='$EDITOR ~/.zshrc'

alias cvrc='cat ~/.vimrc'
alias evrc='$EDITOR ~/.vimrc'

alias hosts='cat ~/.ssh/config'

fe() { du -a --exclude=".git" --exclude="node_modules" | awk '{print $2}' | fzf | xargs -ro $EDITOR ;}
fx() { du -a --exclude=".git" --exclude="node_modules" | awk '{print $2}' | fzf | xargs realpath | tr '\n' ' ' | xsc ;}

clear_git_branches() {
    git branch | grep -vE "main|master|DEV" | xargs git branch -D
}
