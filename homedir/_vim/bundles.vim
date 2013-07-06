set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" rest of bundles
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc'  " remember to make -f your_machines_makefile
NeoBundle 'https://github.com/jnwhiteh/vim-golang.git'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'roman/golden-ratio'

filetype plugin indent on     " Required!
NeoBundleCheck
