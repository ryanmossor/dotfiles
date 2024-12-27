function t() {
    if [[ -z "$1" ]]; then
        if [[ $(pwd) == $HOME ]]; then
            wez cli set-tab-title "home"
        else
            wez cli set-tab-title $(basename $(pwd))
        fi
    else
        wez cli set-tab-title "$1"
    fi
}

# title first word
function tfw() {
    wez cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $1}')
}

# title last word
function tlw() {
    wez cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $NF}')
}

# title working dir
function twd() {
    wez cli set-tab-title $(basename $(pwd))
}
