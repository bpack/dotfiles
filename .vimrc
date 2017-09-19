set nocompatible                 "Be iMproved
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

filetype plugin indent on


" --- Plugin configuration
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1


" --- Standard configurations
syntax enable
set background=dark
colorscheme solarized

set showcmd                      "Show command below status line

set backspace=eol,start,indent   "Backspace freely

set autoindent                   "Turn on auto-indent
set smartindent                  "Interpret indent level
set tabstop=4                    "Four spaces
set shiftwidth=4
set expandtab                    "Convert tabs to spaces
set hlsearch                     "Search highlighting
set mouse=a

set showmatch                    "Highlight matching {[()]}
set ruler                        "Show ruler
set number                       "Display line numbers
set title                        "Set the terminal title

set laststatus=2                 "Next to last line is status line
set statusline=
set statusline+=%-3.3n           "Buffer number
set statusline+=%F               "Full file path
set statusline+=%m               "Modified flag
set statusline+=%=               "Shift to right aligned
set statusline+=[%l/%L,%2v]      "Current line/Total lines, Current Column
set statusline+=\ %y             "File type
set statusline+=\ %3.p%%         "Percent through file

set noerrorbells                 "Turn off error noises
set novisualbell
set t_vb=

set encoding=utf-8
set fileencoding=utf-8

syntax on                        "Turn on syntax highlighting
filetype on                      "Guess file type

set backup                       "Create backup files
set backupdir=~/.vim/backup      "Directory for backup files
set directory=~/.vim/tmp         "Directory for swap files

" --- Commands
" Use :C to clear highlighted search
command! C nohlsearch

" --- File Types
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css,scss setlocal shiftwidth=2 tabstop=2

" --- Key mappings
" Use \t to display n tree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

" Use \b to display tagbar
nmap <silent> <leader>b :TagbarToggle<CR>
