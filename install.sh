#!/usr/bin/env bash

. "$( pwd )/utils.exclude.sh"

# Install brew
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo_with_prompt "Homebrew not installed. Attempting to install Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	if [ ! "$?" -eq 0 ] ; then
		echo_with_prompt "Something went wrong. Exiting..." && exit 1
	fi
fi

# install gnupg
brew install gnupg gnupg2

# runs brew doctor
brew doctor

# installing xcode
xcode-select --install

# updates brew
brew update

# installing git
brew install git

# install password store
git clone git@github.com:lferreira/pwd-store.git ~/.password-store
git clone git@github.com:lferreira/pwd-keys.git

#  Remember to edit the private key gpg --edit-key <private-key>
#  According to this post, OpenKeyChain doesn't suport AEAD encryption
#  (default in gpg 2.3). Dropping the OCB option from the key's preference
#  string also fixed the issue for me:
#
#  gpg --edit-key <key-id>
#	 gpg> showpref
#	 [ultimate] (1).name <email>
#	      Cipher: AES256, AES192, AES, 3DES
#	      AEAD: OCB
#	      Digest: SHA512, SHA384, SHA256, SHA224, SHA1
#	      Compression: ZLIB, BZIP2, ZIP, Uncompressed
#	      Features: MDC, AEAD, Keyserver no-modify
#	 gpg> setpref AES256 AES192 AES 3DES SHA512 SHA384 SHA256 SHA224 SHA1 ZLIB BZIP2 ZIP
#	 Set preference list to:
#	      Cipher: AES256, AES192, AES, 3DES
#	      AEAD:
#	      Digest: SHA512, SHA384, SHA256, SHA224, SHA1
#	      Compression: ZLIB, BZIP2, ZIP, Uncompressed
#	      Features: MDC, Keyserver no-modify
#	 Really update the preferences? (y/N) y
#	 gpg> save
#  pass init <key-id>

gpg --import ~/pwd-keys/private.pgp
gpg --import ~/pwd-keys/public.pgp
rm -rf ~/pwd-keys

# allow changes on the new machine - adds trust|5|save
gpg --edit-key luizhgferreira@gmail.com

cd "$(dirname "${BASH_SOURCE}")";

rm -rf ~/.dotfiles && git clone git@github.com:lferreira/dotfiles.git ~/.dotfiles && cd ~/.dotfiles || exit

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

# create a symbolyc link to ~/.config/skhd
ln -s ~/.dotfiles/skhd ~/.config/skhd

# create a symbolyc link to ~/.config/yabai
ln -s ~/.dotfiles/skhd ~/.config/yabai

echo "Running Brew ..."

## Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

cd ~/.config/brewfile && brew bundle install

# fixes backspace on Apple M1 Pro OSX 12.x
$(brew --prefix)/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
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

# starting skhd
skhd --start-service

# starting yabai
yabai --start-service
