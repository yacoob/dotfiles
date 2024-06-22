-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- nvim settings
vim.cmd([[
" whitespace
set expandtab                   " use spaces, not tabs
set list                        " highlight some special characters
set listchars=tab:\|\ ,trail:·,extends:»,precedes:«
set tabstop=2 shiftwidth=2      " a tab is two spaces
" searching
set gdefault                    " g flag by default for :s
set matchpairs+=<:>             " add < and > to list of "matching" brackets
set showmatch                   " flash matching bracket
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" ui
set guifont=FiraCode\ Nerd\ Font\ Mono\ Retina:h15
set cursorline                  " highlight current line
set scrolloff=14                " leave this amount of lines while scrolling up/down
" behavioral
set autowrite                   " auto-write file before certain operations
set clipboard+=unnamedplus      " always use clipboard for yank/paste
set completeopt+=noinsert,menuone " completion menu options
set formatoptions+=21           " use indent from second line of a paragraph, don't break line after single letter word
set keymodel+=startsel          " shift+special key = selection
set nowritebackup               " no backup files, even while vim is running
set number                      " display current line number
set shortmess-=l                " verbose "x lines, y characters" in messages
set shortmess+=mrwI             " shorter indicators (like [RO]) in messages, no :intro on start
set splitbelow splitright       " change splits placement
set ssop+=winpos,localoptions   " save window positions and local options for :mksession
set undofile                    " write undo history to undo files
]])


-- autocommands
vim.cmd([[
" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" open folds in newly opened files
autocmd BufRead,BufNewFile * normal zR
]])


-- abbrevations
vim.cmd([[
iab --- —
iab --> →
iab <-- ←
iab <expr> dts strftime('%Y-%m-%d')
]])


-- keyboard mappings
vim.cmd([[
" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
nnoremap j gj
nnoremap k gk
" moving whole lines
nmap <C-k> ddkP
nmap <C-j> ddp
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]
" better tab
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv
" easier escape
inoremap jj <ESC>
" forgot your sudo?
cmap w!! w !sudo tee % >/dev/null
" no yank on paste
xnoremap p pgvy
" don't move the cursor on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
" cd to current file's path
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" edit the setting file
nmap <silent> <leader>rc :n $MYVIMRC<CR>
]])
