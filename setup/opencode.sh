#!/usr/bin/env bash
# shellcheck disable=2154

if have opencode; then
    exit 0
fi

if [[ $os == "mac" ]]; then
    brew install anomalyco/tap/opencode
else
    curl -fsSL https://opencode.ai/install | bash
fi
