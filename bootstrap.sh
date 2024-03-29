#!/usr/bin/env bash
# 
# Sets up and symlinks dotfiles

# cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

error () {
  printf "\r\033[2K  [ \033[0;93mER\033[0m ] $1\n"
  echo ''
}

# Arguments
INSTALL_DEPS=true;
HARDCOPY_ALL=false;
# Parse
while [ "$#" -gt 0 ]; do
  case "$1" in
    # Don't install dependencies
    -n|--nodeps) INSTALL_DEPS=false; shift 1;;
    -c|--copyall) HARDCOPY_ALL=true; shift 1;;
    -*) echo "unknown option: $1" >&2; exit 1;;
    *) handle_argument "$1"; shift 1;;
  esac
done

setup_gitconfig () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}


link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=
  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      local currentSrc="$(readlink "$dst")"
      if [ "$currentSrc" == "$src" ]
      then
        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    if [ "$HARDCOPY_ALL" == "false" ]
    then
      # symlink as usual
      ln -s "$1" "$2"
      success "linked $1 to $2"
    else
      # copy, don't symlink
      cp "$1" "$2"
      success "copied $1 to $2"
    fi
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false
  local should_link=true

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    # Give the option to specify a location for a file
    # Check for a script with the .loc suffix
    local locfile="${src%.*}.loc"
    if [ -e $locfile ]
    then
      # Run the script ot get the dest
      dst=$($locfile)
      # Check to see if the location specified is valid
      if [ ! -s "$locfile" ] || [ ! -d "$(dirname "$dst")" ]
      then
        error "$src: Invalid or no link location specified. Skipping."
        continue
      fi
    else
      # Use default location assignment if a custom script doesn't exist
      dst="$HOME/.$(basename "${src%.*}")"  
    fi
    # Link away
    link_file "$src" "$dst"
  done
}

install_dependencies () {
  # Setup homebrew if on a Mac
  if [ "$(uname -s)" == "Darwin" ]
  then
    info "installing dependencies"
    if source bin/dot | while read -r data; do info "$data"; done
    then
      success "dependencies installed"
    else
      fail "error installing dependencies"
    fi
  fi
}

##### Dotfiles #####
setup_gitconfig
install_dotfiles
##### Dependencies #####
if [ "$INSTALL_DEPS" == "true" ]
then
  install_dependencies
else
  info "skipping installing dependencies"
fi
unset INSTALL_DEPS

echo ''
echo '  All installed!'
