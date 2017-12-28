"" GUI specific settings
set guioptions-=T            " don't show toolbar
set guioptions-=m            " no menu

"" OS specific settings
if $OS == "linux"
  set guifont=Anonymice\ Powerline\ Nerd\ Font\ Complete\ 14
endif

if $OS == "osx"
  set guifont=Anonymice\ Powerline\ Nerd\ Font\ Complete:h14
  set fuoptions=maxvert,maxhorz      " use whole screen in fullscreen mode
  " keybindings a'la tpope/vim-unimpaired
  nmap cof :set fullscreen! fullscreen?<CR>
  nmap [of :set fullscreen<CR>
  nmap ]of :set nofullscreen<CR>
endif

"" Visual feedback for insert mode.
" guibg for InsertLeave is specific to jellybeans color scheme.
" TODO: solve this problem for terminal too
au InsertEnter * hi Normal guibg=#000000
au InsertLeave * hi Normal guibg=#151515
