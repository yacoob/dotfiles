set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" rest of bundles
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'bling/vim-airline'
Bundle 'fatih/vim-go'
Bundle 'gregsexton/gitv'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'mhinz/vim-signify'
Bundle 'nanotech/jellybeans.vim'
Bundle 'scrooloose/syntastic'
Bundle 'takac/vim-hardtime'
Bundle 'tpope/vim-fugitive'
Bundle 'zhaocai/GoldenView.Vim'

" untested
Bundle 'tpope/vim-dispatch'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-expand-region'
Bundle 'vim-scripts/gitignore'

" location specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim

filetype plugin indent on     " Required!
