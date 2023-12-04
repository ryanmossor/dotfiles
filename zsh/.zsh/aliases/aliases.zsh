alias a='alias | grep -vE "auto|which|alias" | awk -F= "{ printf \"\033[1;31m%s\033[0m = \033[1;34m\", \$1; for (i = 2; i <= NF; i++) printf \"%s%s\", \$i, (i == NF ? \"\033[0m\n\" : \"=\") }"'

[[ -x $BAT ]] && alias cat='$BAT --theme=Catppuccin-mocha --paging=never'
alias ls='ls --color=auto'
alias ll='ls -laF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if command -v xclip &> /dev/null; then
    alias clip='xclip -selection clipboard'
elif command -v pbcopy &> /dev/null; then
    alias clip='pbcopy'
elif [[ $(uname -a) == *Microsoft* ]]; then
    alias clip='clip.exe'
fi

alias history='history -f 1'

alias cgc='cat ~/.gitconfig'
alias gp='git push origin HEAD'

alias bp='dot && source ~/.zshrc && echo "~/.zshrc reloaded"'
alias cbp='cat ~/.zsh/prompt.zsh ~/.zshrc ~/.zsh/exports.zsh'
alias ebp='$EDITOR ~/.zshrc'

alias cvrc='cat ~/.vimrc'
alias evrc='$EDITOR ~/.vimrc'

alias hosts='cat ~/.ssh/config'

alias fzp='fzf --preview "$BAT --color=always --theme=Catppuccin-mocha --style=numbers --line-range=:500 {}"'
alias fze='fzp | xargs -ro code'
alias fzv='fzp | xargs -ro vim'
alias fzx='fzp | xargs realpath | tr "\n" " " | clip'

alias clear_git_branches='git branch | grep -vE "main|master|DEV" | xargs git branch -D'
