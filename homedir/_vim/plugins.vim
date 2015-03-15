call plug#begin('~/.vim/plugged')

" bundles
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'bling/vim-airline'
Plug 'fatih/vim-go'
Plug 'gregsexton/gitv'
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vasconcelloslf/vim-interestingwords'
Plug 'vim-scripts/gitignore'
Plug 'zhaocai/GoldenView.Vim'

" untested

" location/os specific bundles
silent! source ~/.vim/plugins.$LOCATION.vim
silent! source ~/.vim/plugins.$OS.vim
call plug#end()
