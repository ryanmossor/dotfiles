#!/usr/bin/env bash

[ ! -d ~/.fzf ] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
pushd ~/.fzf &> /dev/null || exit
git pull
./install --key-bindings --completion --no-update-rc
popd &> /dev/null || exit

