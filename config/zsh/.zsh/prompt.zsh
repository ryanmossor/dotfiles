parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ 󰘬 \1/"
}

setopt PROMPT_SUBST

ARROW='%(?.%F{green}.%F{red})→%f'
DIR='%F{blue}%~%f'
BRANCH='%F{yellow}$(parse_git_branch)%f'

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME='%F{green}%n@%m%f '
fi

PS1="%B${ARROW} ${HOST_NAME}${DIR}${BRANCH}%b "
