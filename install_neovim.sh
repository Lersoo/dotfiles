#!/bin/sh

VIMRC_SOURCE=$(readlink -f vimrc)
NVIM_CONFIG=~/.config/nvim/init.vim
NVIM_INSTALL_PATH=/usr/local/bin/nvim

if [[ -f $NVIM_INSTALL_PATH ]]; then
  echo "Neovim is already installed on your machine! 🎉"
else
  # Install Neovim if it is not installed
  APPIMAGE_PATH="https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage" # Update this link for new releases
  wget $APPIMAGE_PATH
  mv nvim.appimage nvim
  sudo chmod u+x nvim
  sudo mv nvim /usr/local/bin

  if ! command -v nvim; then
    echo "Neovim has been installed on your machine! 🎉"
  else
    echo "Something went wrong. You might want to check your Neovim install at $NVIM_INSTALL_PATH"
  fi
fi

# Checking existence of symlink between virc & Neovim

if [[ -L $NVIM_CONFIG ]]; then
  echo "Symlink exists between dotfiles vimrc & neovim config file!"
else
  # Create symlink with default Neovim config file
  echo "Creating symlink between $VIMRC_SOURCE & $NVIM_CONFIG"
  sudo ln -sf $VIMRC_SOURCE $NVIM_CONFIG
fi

