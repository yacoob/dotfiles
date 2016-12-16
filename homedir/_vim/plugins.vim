" autoinstall vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let g:plug_shallow = 1
call plug#begin('~/.vim/plugged')

" bundles
Plug 'Raimondi/delimitMate'                " auto-closing of quotes, parenthesis and brackets
Plug 'Valloric/ListToggle'                 " quick toggle for location and quickfist lists
Plug 'bling/vim-airline'                   " status line
Plug 'brooth/far.vim'                      " find&replace on steroids
Plug 'ctrlpvim/ctrlp.vim'                  " fuzzy file/buffer/etc finder
Plug 'gregsexton/gitv'                     " gitk in vim
Plug 'junegunn/goyo.vim'                   " distraction-free mode
Plug 'junegunn/limelight.vim'              " dim syntax in other parts of the file
Plug 'justinmk/vim-sneak'                  " middle ground between f and /
Plug 'majutsushi/tagbar'                   " tagbar
Plug 'mhinz/vim-signify'                   " vcs modification marks
Plug 'nathanaelkane/vim-indent-guides'     " alternating colors for indent guides
Plug 'regedarek/ZoomWin'                   " toggle between single/multi window
Plug 'rking/ag.vim'                        " ag integration
Plug 'scrooloose/syntastic'                " syntax checking
Plug 'sjl/gundo.vim'                       " undo tree visualisation
Plug 'terryma/vim-expand-region'           " quick selection expansion for visual mode
Plug 'tpope/vim-commentary'                " quick comment out/in
Plug 'tpope/vim-fugitive'                  " git integration
Plug 'tpope/vim-unimpaired'                " various navigation and convenience toggles
Plug 'vasconcelloslf/vim-interestingwords' " arbitrary phrase highlighter
Plug 'vim-scripts/gitignore'               " merge .gitignore into wildignore

"colorschemes
Plug 'nanotech/jellybeans.vim'

" untested
Plug 'tpope/vim-surround'                  " quick 'surrounds' editing
Plug 'lepture/vim-jinja'                   " jinja ft plugin

" location/os specific bundles
silent! source ~/.vim/plugins.$LOCATION.vim
silent! source ~/.vim/plugins.$OS.vim
call plug#end()

