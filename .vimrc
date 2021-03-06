" Ctrl+s as Save
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a


" ================ General Config ====================

set fileencoding=utf-8
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" =========== Editing Config =======================
set nolist
set hlsearch

"turn on syntax highlighting
syntax on

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
" NOT WORKING: Didnt work when yanked right out of YADR
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Appearence Config ================
set encoding=utf-8
syntax enable
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme base16-solarized-dark

" Statusbar
set statusline=\ %f\  " Filename
set statusline+=%{fugitive#statusline()} " Git info
" Column ruler
set colorcolumn=120

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ===== SYNTASTIC 
"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:syntastic_auto_loc_list=1
"don't care about warnings
let g:syntastic_quiet_warnings=0

" ##################
" Language Specifics
" ##################
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:markdown_minlines = 100
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'scala', 'go']
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set rtp+=~/.vim/godoctor.vim
filetype plugin indent on
syntax on

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html       setlocal shiftwidth=2 tabstop=2
autocmd FileType python     setlocal shiftwidth=4 softtabstop=4 expandtab

" #######
" Enable emmet just for html/css
" #######
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'html' : {
\      'snippets' : {
\            'html:5': "<!DOCTYPE html>\n"
\                    ."<html lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."\t<meta charset=\"${charset}\">\n"
\		     ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n"	
\                    ."\t<meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n"
\                    ."\t<title></title>\n"
\                    ."\t<link href=\"\">\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>"
\      }
\   }
\}
