#!/usr/bin/env bash
# shellcheck disable=2154

if [[ "$os" == "ubuntu" ]]; then
    if [ -x "$HOME/Applications/Postman/Postman" ]; then
        echo "Postman already installed."
        exit 0
    fi

    pushd /tmp &> /dev/null || exit
    wget -O postman.tar.gz "https://dl.pstmn.io/download/latest/linux_64"
    tar xzf postman.tar.gz
    mv Postman "$HOME/Applications"
    popd &> /dev/null || exit
fi

