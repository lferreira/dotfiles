.PHONY : applications/vim

# Configuration
user-nick = $(USER)
golang-version = $(GO_VERSION)
VIM_PATH = ~/.vim

env/install: 
	./brew.sh
	./install.sh
	@$(MAKE) applications/vim

applications/vim: ~/.vimrc
	rm -rf $(VIM_PATH)/pack
	mkdir -p $(VIM_PATH)/backups $(VIM_PATH)/pack/plugins/start
	cd $(VIM_PATH)/pack/plugins/start \
		&& git clone https://github.com/chriskempson/base16-vim.git \
		&& git clone https://github.com/fatih/vim-go.git \
		&& git clone https://github.com/godoctor/godoctor.vim ~/.vim/godoctor.vim \
		&& git clone https://github.com/tpope/vim-fugitive.git \
		&& git clone https://github.com/tpope/vim-markdown.git \
		&& git clone https://github.com/tpope/vim-repeat.git \
		&& git clone https://github.com/tpope/vim-rsi.git \
		&& git clone https://github.com/tpope/vim-sensible.git \
		&& git clone https://github.com/tpope/vim-sleuth.git \
		&& git clone https://github.com/tpope/vim-surround.git \
		&& git clone https://github.com/tpope/vim-vinegar.git \
		&& git clone https://github.com/pangloss/vim-javascript \
		&& git clone https://github.com/alvan/vim-closetag \
		&& git clone https://github.com/mattn/emmet-vim 
