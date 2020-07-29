#!/bin/sh
#
# Node
#
# This globally installs Node packages that I like

# Install N
# https://github.com/tj/n
if [[ "$OSTYPE" == "darwin"* ]]; then
    if test ! $(which n)
    then
        echo "Installing n"
        $(sudo npm install -g n)
        # Install the latest stable version of node (separate from what brew says)
        $(n latest)
        # Kick npm for good measure
        $(curl -0 -L https://npmjs.com/install.sh | sudo sh)
    fi
else
    echo "Not on macOS - skipping node n installation."
fi

# Install Trash
# https://github.com/sindresorhus/trash
if [[ "$OSTYPE" == "darwin"* ]]; then
    if test ! $(which trash)
    then
        $(sudo npm install -g trash-cli)
    fi
else
    echo "Not on macOS - skipping node trash installation."
fi

