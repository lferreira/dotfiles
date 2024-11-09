#!/bin/bash

original_dir=$(pwd)

target_dir="$HOME/.dotfiles"

cd "$target_dir" || exit

git pull --rebase  

cd .config/brewfile

brew update
brew bundle install

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# return to the original directory
cd "$original_dir" || exit

source $HOME/.bash_profile


