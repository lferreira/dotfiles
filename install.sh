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

# creates a symbolyc link to ~/.tmux.conf
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# creates a symbolyc link to ~/.tmux
ln -s ~/.dotfiles/tmux ~/.tmux

# create a symbolyc link to ~/.tmate.conf
ln -s ~/.dotfiles/tmate/.tmate.conf ~/.tmate.conf

echo "Running Brew ..."

## Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

cd ~/.config/brewfile/

brew bundle install

chsh -s /bin/zsh

# Oh my ZSH - robbyrussel
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# installing gvm - golang version manager
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# creates a symbolyc link with ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim

# golang dependencies for cmp/lsp
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/gopls@latest

vim +PlugInstall +qall

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
