#!/bin/bash

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

# zsh plugins
CURRENT_DIR=`pwd`
cd "$CURRENT_DIR"

if [[ ! `uname` =~ "darwin" ]]; then
  # Cleanup
  read -p "Do you want to cleanup? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    [ -f ~/.zshrc ] && rm ~/.zshrc
    [ -f ~/.bashrc ] && rm ~/.bashrc
    [ -f ~/.bash_profile ] && rm ~/.bash_profile
    [ -f ~/.profile ] && rm ~/.profile
    [ -f ~/.bash_logout ] && rm ~/.bash_logout
  else
    echo "Skipping cleanup"
  fi

  # Install Homebrew
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Update package list
  brew update
  brew upgrade

  # Install zsh
  brew install zsh

  # Install oh-my-zsh & spaceship theme
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

  # Install zsh plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  # Install packages
  brew install bat
  brew install diff-so-fancy
  brew install eza
  brew install fzf
  brew install git
  brew install heroku
  brew install neovim
  brew install warp
  brew install zed

  # Install NVM
  sh -c $(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh)

  # Install rbenv
  brew install rbenv ruby-build

fi

backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ]; then
      backup $target

      if [ ! -e "$target" ]; then
        echo "-----> Symlinking your new $target"
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done

exec zsh
