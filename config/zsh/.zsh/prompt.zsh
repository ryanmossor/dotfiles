parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ 󰘬 \1/"
}

autoload -Uz colors && colors
setopt PROMPT_SUBST

ARROW='%(?.%{$fg_bold[green]%}→.%{$fg_bold[red]%}✘)%{$reset_color%}'
DIR="%{$fg_bold[blue]%}%~%{$reset_color%}"
BRANCH="%{$fg_bold[yellow]%}\$(parse_git_branch)%{$reset_color%}"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME="%{$fg_bold[green]%}%n@%m%{$reset_color%} "
fi

PS1="%B${ARROW} ${HOST_NAME}${DIR}${BRANCH}%b "
