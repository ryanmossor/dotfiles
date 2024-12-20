#!/usr/bin/env bash
# shellcheck disable=2154

if [[ "$os" == "mac" ]]; then
    brew install jesseduffield/lazygit/lazygit
else
    lazygit_latest=$(github_latest_tag "jesseduffield/lazygit")
    lazygit_current=$(lazygit -v 2> /dev/null | cut -d ' ' -f 6 | sed 's/version=\(.*\),/\1/')
    if [[ "$lazygit_current" == "$lazygit_latest" ]]; then
        echo "Lazygit already up to date."
        exit 0
    fi

    pushd /tmp &> /dev/null || exit
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_latest}/lazygit_${lazygit_latest}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    popd &> /dev/null || exit
fi

