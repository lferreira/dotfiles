#!/usr/bin/env bash

. "$( pwd )/utils.exclude.sh"

# Install brew
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo_with_prompt "Homebrew not installed. Attempting to install Homebrew"
	/usr/bin/ruby -e "$(curl -o brewinstall.sh -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	chmod 755 ./brewinstall.sh
	rm -f brewinstall
	if [ ! "$?" -eq 0 ] ; then
		echo_with_prompt "Something went wrong. Exiting..." && exit 1
	fi
fi

# runs brew doctor
brew doctor

# installing xcode
xcode-select --install

# updates brew
brew update

# installing git
brew install git to clone dotfiles

cd "$(dirname "${BASH_SOURCE}")";

git clone git@github.com:lferreira/dotfiles.git ~/.dotfiles && cd ~/.dotfiles || exit

# copying .files
rsync -vt ~/.dotfiles/.* ~/

# creates an .config directory
mkdir ~/.config

# creates a symbolyc link to ~/.config/brewfile/
ln -s ~/.dotfiles/brewfile ~/.config/brewfile

# creates a symbolyc link to ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim

# creates a symbolyc link to ~/.config/tmux
ln -s ~/.dotfiles/tmux ~/.config/tmux

# create a symbolyc link to ~/.config/tmate
ln -s ~/.dotfiles/tmate ~/.config/tmate

echo "Running Brew ..."

## Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

brew bundle install

# fixes backspace on Apple M1 Pro OSX 12.x
$(brew --prefix)/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info                                                                                                                             eks-prod
tic -xe tmux-256color ~/tmux-256color.info

chsh -s /bin/zsh

# Oh my ZSH - robbyrussel
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# installing gvm - golang version manager
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# golang dependencies for cmp/lsp
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/gopls@latest

vim +PlugInstall +qall

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
