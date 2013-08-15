set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" rest of bundles
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'bling/vim-airline'
NeoBundle 'jnwhiteh/vim-golang.git'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/syntastic'

" location specific bundles
silent! source ~/.vim/bundles.$LOCATION.vim

filetype plugin indent on     " Required!
NeoBundleCheck
