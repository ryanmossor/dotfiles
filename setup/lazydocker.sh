#!/usr/bin/env bash
# shellcheck disable=2154

if [[ "$os" == "mac" ]]; then
    brew install jesseduffield/lazydocker/lazydocker
else
    lazydocker_latest=$(github_latest_tag "jesseduffield/lazydocker")
    lazydocker_current=$(lazydocker -v 2> /dev/null | cut -d ' ' -f 6 | sed 's/version=\(.*\),/\1/')
    if [[ "$lazydocker_current" == "$lazydocker_latest" ]]; then
        echo "Lazydocker already up to date."
        exit 0
    fi

    pushd /tmp &> /dev/null || exit
    curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${lazydocker_latest}/lazydocker_${lazydocker_latest}_Linux_x86_64.tar.gz"
    tar xf lazydocker.tar.gz lazydocker
    sudo install lazydocker -D -t /usr/local/bin/
    popd &> /dev/null || exit
fi

