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

# runs brew doctor
brew doctor

# installing xcode
xcode-select --install

# updates brew
brew update

# copying .files
rm -rf ~/.dotfiles && git clone git@github.com:lferreira/dotfiles.git ~/.dotfiles && cd ~/.dotfiles || exit
rsync -vt ~/.dotfiles/.* ~/

# creates an .config directory
mkdir ~/.config

# symbolic links
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.alias ~/.alias
ln -s ~/.dotfiles/.bash_profile ~/.bash_profile
ln -s ~/.dotfiles/.extras ~/.extras
ln -s ~/.dotfiles/.exports ~/.exports

ln -s ~/.dotfiles/brewfile ~/.config/brewfile
ln -s ~/.dotfiles/brewfile/Brewfile ~/.config/brewfile/Brewfile

ln -s ~/.dotfiles/nvim ~/.config/nvim

ln -s ~/.dotfiles/tmux ~/.config/tmux

ln -s ~/.dotfiles/tmate ~/.config/tmate

ln -s ~/.dotfiles/skhd ~/.config/skhd

ln -s ~/.dotfiles/yabai ~/.config/yabai

ln -s ~/.dotfiles/alacritty ~/.config/alacritty

echo "Running Brew ..."

## Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

brew bundle install

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

vim +PlugInstall +qall

echo "Installing Neovim plugins ..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# starting skhd
skhd --start-service

# starting yabai
yabai --start-service
