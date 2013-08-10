set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" rest of bundles
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'  " needs: make -f your_machines_makefile
NeoBundle 'bling/vim-airline'
NeoBundle 'jnwhiteh/vim-golang.git'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/syntastic'

silent! source bundles.${LOCATION}.vim

filetype plugin indent on     " Required!
NeoBundleCheck
