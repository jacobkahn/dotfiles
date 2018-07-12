#!/bin/sh
#
# Oh My Zsh
#
# This installs Oh My Zsh, and changes the default directory to the appropriate directory

echo "Installing shell."
# Choose the type of shell to install!
SHELLTYPE="oh-my-zsh"
# Check if we have an existing version installed in the correct location
if [ "$SHELLTYPE" = "oh-my-zsh" ]
then
  echo "Selected shell is Oh My Zsh."
  if [ ! -d "$OHMYZSH" ]
  then
      echo "Installing Oh My Zsh."
      # Set the install path to not use the ~/.dotfiles directory
      export ZSH="$OHMYZSH"
      # Install
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
      # Move the default zshrc file into .dotfiles
      mv -n "$HOME/.zshrc" "$DOTFILES/zsh/oh-my-zshrc"
  else
      echo "Oh My Zsh is already installed."
  fi
elif  [ "$SHELLTYPE" = "prezto" ]
then
  echo "Selected shell is Prezto."
  # Install it at ~
  if [ ! -d "$HOME/.zprezto" ]
  then
      echo "Installing Prezto."
      # Install
      "$(git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto")"
      # Move the default zpreztorc file into ~/.dotfiles
      mv -n "$HOME/.zprezto/runcoms/zpreztorc" "$DOTFILES/zsh/zpreztorc.symlink"
  else
      echo "Prezto is already installed."
  fi
else
  echo "Selected shell not recognized."
fi

unset SHELLTYPE