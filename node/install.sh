#!/bin/sh
#
# Node
#
# This globally installs Node packages that I like

# Install N
# https://github.com/tj/n
if test ! $(which n)
then
  $(sudo npm install -g n)
  # Install the latest stable version of node (separate from what brew says)
  $(n latest)
  # Kick npm for good measure
  $(curl -0 -L https://npmjs.com/install.sh | sudo sh)
fi

# Install Trash
# https://github.com/sindresorhus/trash
if test ! $(which trash)
then
  $(sudo npm install -g trash-cli)
fi

