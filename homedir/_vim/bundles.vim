set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle itself
Bundle 'gmarik/vundle'

" ...rest of bundles
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache'
Bundle 'kien/ctrlp.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'roman/golden-ratio'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'https://github.com/jnwhiteh/vim-golang.git'

filetype plugin indent on
