set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

" bundles
Plugin 'Raimondi/delimitMate'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
"Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'gregsexton/gitv'
"Plugin 'honza/vim-snippets.git'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mhinz/vim-signify'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/syntastic'
Plugin 'takac/vim-hardtime'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/gitignore'
Plugin 'zhaocai/GoldenView.Vim'

" untested

" location/os specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim
silent! source ~/.vim/bundles.$OS.vim

filetype plugin indent on     " Required!
