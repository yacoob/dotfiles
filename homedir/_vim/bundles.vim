set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

" rest of bundles
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'gregsexton/gitv'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mhinz/vim-signify'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/syntastic'
Plugin 'takac/vim-hardtime'
Plugin 'tpope/vim-fugitive'
Plugin 'zhaocai/GoldenView.Vim'

" untested
Plugin 'tpope/vim-dispatch'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'vim-scripts/gitignore'

" location/os specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim
silent! source ~/.vim/bundles.$OS.vim

filetype plugin indent on     " Required!
