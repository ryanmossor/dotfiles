function t() {
    if [[ -z "$1" ]]; then
        wez cli set-tab-title $(basename $SHELL)
    else
        wez cli set-tab-title "$1"
    fi
}

# title first word
alias tfw="wez cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $1}')"
# title last word
alias tlw="wez cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $NF}')"
# title working dir
alias twd="wez cli set-tab-title $(basename $(pwd))"
