set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" rest of bundles
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'bling/vim-airline'
Bundle 'gregsexton/gitv'
Bundle 'jnwhiteh/vim-golang.git'
Bundle 'nanotech/jellybeans.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

" untested
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'zhaocai/GoldenView.Vim'

" location specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim

filetype plugin indent on     " Required!
