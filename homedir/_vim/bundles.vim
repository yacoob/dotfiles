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
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'nanotech/jellybeans.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'zhaocai/GoldenView.Vim'

" untested
Bundle 'tpope/vim-dispatch'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-expand-region'
Bundle 'vim-scripts/gitignore'
Bundle 'fatih/vim-go'

" location specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim

filetype plugin indent on     " Required!
