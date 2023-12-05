parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

autoload -Uz colors && colors
setopt PROMPT_SUBST

ARROW="%{$fg[green]%}>%{$reset_color%}"
DIR="%{$fg[blue]%}%~%{$reset_color%}"
BRANCH="%{$fg[magenta]%}\$(parse_git_branch)%{$reset_color%}"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME="%{$fg[green]%}%n@%m%{$reset_color}:"
    PS1="%B${HOST_NAME}${DIR}${BRANCH}%b$ "
else
    PS1="%B${DIR}${BRANCH} ${ARROW}%b "
fi
