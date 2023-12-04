parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

setopt PROMPT_SUBST
ARROW="%F{010}>%f"
DIR="%F{004}%~%f"
BRANCH="%F{219}\$(parse_git_branch)%f"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    HOST_NAME="%F{010}%n@%m%f:"
    PS1="%B${HOST_NAME}${DIR}${BRANCH}%b$ "
else
    PS1="%B${DIR}${BRANCH} ${ARROW}%b "
fi
