set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle itself
Bundle 'gmarik/vundle'

" ...rest of bundles
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'nanotech/jellybeans.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'roman/golden-ratio'

filetype plugin indent on