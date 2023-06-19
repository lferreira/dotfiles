#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git clone git@github.com:lferreira/dotfiles.git ~/.dotfiles && cd ~/.dotfiles || exit

# creates an .config directory
mkdir ~/.config

# creates a symbolyc link with ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim

go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/gopls@latest

vim +PlugInstall +qall

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

