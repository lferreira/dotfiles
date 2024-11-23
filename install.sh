#!/usr/bin/env bash

. "$( pwd )/utils.exclude.sh"

# Install brew
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo_with_prompt "Homebrew not installed. Attempting to install Homebrew"
	export HOMEBREW_NO_INSTALL_FROM_API=1 && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	if [ ! "$?" -eq 0 ] ; then
		echo_with_prompt "Something went wrong. Exiting..." && exit 1
	fi
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# installing xcode
xcode-select --install

# stow
cd $HOME/.dotfiles

stow zshrc
stow alias
stow bash_profile
stow env-golang
stow extras
stow exports
stow inputrc
stow hushlogin
stow gitignore_global
stow gitconfig
stow gitconfig_work
stow gitconfig_personal

stow -t ~ alacritty
stow -t ~ brewfile
stow -t ~ nvim
stow -t ~ skhd
stow -t ~ tmate
stow -t ~ tmux
stow -t ~ yabai

echo "Running Brew ..."

## Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

cd $HOME/.config/brewfile && brew update && brew bundle install

cd "$(dirname "${BASH_SOURCE}")";

# fixes backspace on Apple M1 Pro OSX 12.x
$(brew --prefix)/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
tic -xe tmux-256color ~/tmux-256color.info

chsh -s /bin/zsh

# Oh my ZSH - robbyrussel
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# installing gvm - golang version manager
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# golang dependencies for cmp/lsp
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/gopls@latest
vim +PlugInstall +qall

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# starting skhd
skhd --start-service

# starting yabai
yabai --start-service
