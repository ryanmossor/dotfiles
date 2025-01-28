alias a='alias | grep -vE "auto|which|alias" | awk -F= "{ printf \"\033[0;31m%s\033[0m = \033[0;36m\", \$1; for (i = 2; i <= NF; i++) printf \"%s%s\", \$i, (i == NF ? \"\033[0m\n\" : \"=\") }"'
alias fa='alias | grep -E "^fz" | awk -F= "{ printf \"\033[0;31m%s\033[0m = \033[0;36m\", \$1; for (i = 2; i <= NF; i++) printf \"%s%s\", \$i, (i == NF ? \"\033[0m\n\" : \"=\") }"'
alias ga='git config --get-regexp "alias.*" | sed "s/alias\.//" | sed "s/[ ]/ = /"'

alias ls='ls --color=auto'
alias ll='ls -laF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if have xclip; then
    alias clip='xclip -selection clipboard'
elif have pbcopy; then
    alias clip='pbcopy'
elif [[ $(uname -a) == *microsoft* ]]; then
    alias clip='clip.exe'
fi

have bat && alias cat='$BAT --theme=Catppuccin-mocha --paging=never'
have fdfind && alias fd='fdfind'

alias ld='lazydocker'
alias lg='lazygit'

if have az; then
    alias azsubs="az account list | jq -r '.[] | \"[\(.tenantDisplayName)]\n\(.name)\n\(.id)\n\"'"
    alias azcurrent="az account list | jq -r '.[] | select(.isDefault == true) | .tenantDisplayName, .name, .id'"
fi

alias history='history -f 1'

alias update='$DOTFILES/install.sh'

alias cgc='cat ~/.gitconfig'
alias gp='git push origin HEAD'
alias gpf='git push origin HEAD --force-with-lease'

alias bp='dot && source ~/.zshrc && echo "~/.zshrc reloaded"'
alias cbp='cat ~/.zshrc ~/.zsh/exports.zsh'
alias ebp='$EDITOR ~/.zshrc'

alias vim='nvim'

alias cvrc='cat ~/.vimrc'
alias evrc='$EDITOR ~/.vimrc'

alias hosts='cat ~/.ssh/config'

alias fzp='fzf --preview "$BAT --color=always --theme=Catppuccin-mocha --style=numbers --line-range=:500 {}"'
alias fzc='fzf-cd-code-projects'
alias fze='fzp | xargs -ro code'
alias fzv='fzp | xargs -ro vim'
#alias fzx='fzp | xargs realpath | tr "\n" " " | clip'
alias fzx='fzp | tr "\n" " " | clip'

wez() {
    if [[ $(uname -a) == *microsoft* ]]; then
        wezterm.exe "$@"
    else
        wezterm "$@"
    fi
}
