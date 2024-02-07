alias a='alias | grep -vE "auto|which|alias" | awk -F= "{ printf \"\033[0;31m%s\033[0m = \033[0;36m\", \$1; for (i = 2; i <= NF; i++) printf \"%s%s\", \$i, (i == NF ? \"\033[0m\n\" : \"=\") }"'
alias fa='alias | grep -E "^fz" | awk -F= "{ printf \"\033[0;31m%s\033[0m = \033[0;36m\", \$1; for (i = 2; i <= NF; i++) printf \"%s%s\", \$i, (i == NF ? \"\033[0m\n\" : \"=\") }"'
alias ga='git config --get-regexp "alias.*" | sed "s/alias\.//" | sed "s/[ ]/ = /"'

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
elif [[ $(uname -a) == *microsoft* ]]; then
    alias clip='clip.exe'
fi

if command -v fdfind &> /dev/null; then
    alias fd='fdfind'
fi

alias history='history -f 1'

alias cgc='cat ~/.gitconfig'
alias gp='git push origin HEAD'
alias gpf='git push origin HEAD --force-with-lease'

alias bp='dot && source ~/.zshrc && echo "~/.zshrc reloaded"'
alias cbp='cat ~/.zshrc ~/.zsh/exports.zsh'
alias ebp='$EDITOR ~/.zshrc'

alias cvrc='cat ~/.vimrc'
alias evrc='$EDITOR ~/.vimrc'

alias hosts='cat ~/.ssh/config'

alias fzp='fzf --preview "$BAT --color=always --theme=Catppuccin-mocha --style=numbers --line-range=:500 {}"'
alias fzc='fzf-cd-code-projects'
alias fze='fzp | xargs -ro code'
alias fzv='fzp | xargs -ro vim'
#alias fzx='fzp | xargs realpath | tr "\n" " " | clip'
alias fzx='fzp | tr "\n" " " | clip'

# TODO: move to .gitconfig
alias rm-branches='git branch | grep -vE "main|master|DEV" | xargs git branch -D'

fzf-cd-code-projects() {
    local dirs=(
        "$HOME/code"
        "$HOME/code/work"
        "$WIN_HOME/code"
        "$WIN_HOME/code/work"
        "$WIN_HOME/code/work/candidates"
    )

    local selected=$(fd . "${dirs[@]}" --exact-depth 1 -t d &> /dev/null | fzf)

    if [[ -z "$selected" ]]; then
        exit 0
    fi

    cd "$selected"

    if [[ $(uname -a) == *microsoft* ]]; then
        fd . --max-depth 2 -t f -e sln &> /dev/null | tee >(head -n 1 | tr "\n" " " | clip)
    fi
}
