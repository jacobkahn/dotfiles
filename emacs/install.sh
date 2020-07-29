#!/bin/zsh
#
# Grab emacs integrations files and dump them in $DOTFILES/emacs/integrations
#

# Used in emacs to set the load path
DOTFILES_EMACS_INTEGRATIONS_DIR=$DOTFILES/emacs/integrations

if [ ! -f $DOTFILES_EMACS_INTEGRATIONS_DIR/clang-format.el ]
then
    # clang-format.el
    get_clang_format="curl -fsSL https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/clang-format.el > $DOTFILES_EMACS_INTEGRATIONS_DIR/clang-format.el"
    echo "› $get_clang_format"
    sh -c "$get_clang_format"
else
    echo "Found clang-format.el - skipping"
fi

if [ ! -f $DOTFILES_EMACS_INTEGRATIONS_DIR/cmake-mode.el ]
then
    # cmake-mode.el
    get_cmake_mode="curl -fsSL https://raw.githubusercontent.com/Kitware/CMake/master/Auxiliary/cmake-mode.el > $DOTFILES_EMACS_INTEGRATIONS_DIR/cmake-mode.el"
    echo "› $get_cmake_mode"
    sh -c "$get_cmake_mode"
else
    echo "Found cmake-mode.el - skipping"
fi

unset DOTFILES_EMACS_INTEGRATIONS_DIR
