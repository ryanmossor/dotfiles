#!/usr/bin/env bash

[[ "$os" == "ubuntu" ]] && sudo apt-get install -y libfuse2
[[ "$os" == "omarchy" ]] && omarchy-pkg-aur-add lib32-fuse2
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

