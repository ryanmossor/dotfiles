parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

autoload -Uz colors && colors
setopt PROMPT_SUBST

ARROW="%{$fg_bold[green]%}>%{$reset_color%}"
DIR="%{$fg_bold[blue]%}%~%{$reset_color%}"
BRANCH="%{$fg_bold[magenta]%}\$(parse_git_branch)%{$reset_color%}"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME="%{$fg_bold[green]%}%n@%m%{$reset_color%}:"
    PS1="%B${HOST_NAME}${DIR}${BRANCH}%b$ "
else
    PS1="%B${DIR}${BRANCH} ${ARROW}%b "
fi
