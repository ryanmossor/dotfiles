function t() {
    if [[ -z "$1" ]]; then
        wezterm cli set-tab-title $(basename $SHELL)
    else
        wezterm cli set-tab-title "$1"
    fi
}

# title first word
function tfw() {
    wezterm cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $1}')
}

# title last word
function tlw() {
    wezterm cli set-tab-title $(basename $(pwd) | sed 's/[._-]/ /g' | awk '{print $NF}')
}

# title shell
function tsh() {
    wezterm cli set-tab-title $(basename $SHELL)
}

# title working dir
function twd() {
    wezterm cli set-tab-title $(basename $(pwd))
}
