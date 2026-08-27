#!/usr/bin/env bash

have opencode && exit 0

case "$os" in
    mac)     brew install anomalyco/tap/opencode ;;
    omarchy) omarchy-default-agent --install "opencode" ;;
    ubuntu)  curl -fsSL https://opencode.ai/install | bash ;;
    *)       echo "OS not supported. Skipping opencode installation." ;;
esac
