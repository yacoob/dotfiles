set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" rest of bundles
Bundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
Bundle 'bling/vim-airline'
Bundle 'gregsexton/gitv'
Bundle 'jnwhiteh/vim-golang.git'
Bundle 'nanotech/jellybeans.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/unite.vim'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'

" location specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim

filetype plugin indent on     " Required!
