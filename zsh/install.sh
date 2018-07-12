#!/bin/sh
#
# Oh My Zsh
#
# This installs Oh My Zsh, and changes the default directory to the appropriate directory

# Check if we have an existing version installed in the correct location
if [ ! -d "$OHMYZSH" ]
then
    echo "Installing Oh My Zsh."
    # Set the install path to not use the ~/.dotfiles directory
    export ZSH="$OHMYZSH"
    # Install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Move the zshrc file into .dotfiles
    mv "$HOME/.zshrc" "$DOTFILES/zsh/oh-my-zshrc"
else
    echo "Oh My Zsh is already installed."
fi