" autoinstall vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let g:plug_shallow = 1
silent! call plug#begin('~/.vim/plugged')

" bundles
Plug 'bling/vim-airline'                   " status line
Plug 'brooth/far.vim'                      " find&replace on steroids
Plug 'ctrlpvim/ctrlp.vim'                  " fuzzy file/buffer/etc finder
Plug 'fatih/vim-go'                        " better golang support
Plug 'gregsexton/gitv'                     " gitk in vim
Plug 'inside/vim-search-pulse'             " pulse current line after search
Plug 'junegunn/goyo.vim'                   " distraction-free mode
Plug 'junegunn/limelight.vim'              " dim syntax in other parts of the file
Plug 'justinmk/vim-sneak'                  " middle ground between f and /
Plug 'lepture/vim-jinja'                   " jinja ft plugin
Plug 'lilydjwg/colorizer'                  " sets background under color definitions
Plug 'luochen1990/rainbow'                 " rainbow parentheses :D
Plug 'majutsushi/tagbar'                   " tagbar
Plug 'mattn/webapi-vim'                    " extra bob for :RustPlay
Plug 'mbbill/undotree'                    " undo tree visualisation
Plug 'mhinz/vim-signify'                   " vcs modification marks
Plug 'nathanaelkane/vim-indent-guides'     " alternating colors for indent guides
Plug 'Raimondi/delimitMate'                " auto-closing of quotes, parenthesis and brackets
Plug 'regedarek/ZoomWin'                   " toggle between single/multi window
Plug 'rking/ag.vim'                        " ag integration
Plug 'rust-lang/rust.vim'                  " Rust support
Plug 'terryma/vim-expand-region'           " quick selection expansion for visual mode
Plug 'tpope/vim-commentary'                " quick comment out/in
Plug 'tpope/vim-fugitive'                  " git integration
Plug 'tpope/vim-surround'                  " quick 'surrounds' editing
Plug 'tpope/vim-unimpaired'                " various navigation and convenience toggles
Plug 'Valloric/ListToggle'                 " quick toggle for location and quickfist lists
Plug 'vasconcelloslf/vim-interestingwords' " arbitrary phrase highlighter
Plug 'vim-airline/vim-airline-themes'      " airline themes
Plug 'vim-scripts/CursorLineCurrentWindow' " current line highlight only in active buffer
Plug 'vim-scripts/gitignore'               " merge .gitignore into wildignore
Plug 'dense-analysis/ale'                  " linting and autocompletion
Plug 'yuttie/comfortable-motion.vim'       " intertial scrolling

"colorschemes
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'

" untested
Plug 'kana/vim-narrow'                     " narrowing
Plug 'sjl/splice.vim'                      " diff/merge plugin

" machine specific config
silent! source ~/.vim/plugins.local.vim
call plug#end()
