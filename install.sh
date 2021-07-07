#!/usr/bin/env bash

set -e

git pull origin main

# Choose config depending on OS
if [ $(uname -s) == Darwin ]; then
    CONFIG="config/macos.yaml"
elif [ $(uname -r) == "*WSL2" ]; then
    CONFIG="config/wsl.yaml"
else
    CONFIG="config/linux.yam"
fi

DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Download submodules
cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

# Run dotbot
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
