"" GUI specific settings
set guioptions-=T            " don't show toolbar
set guioptions-=m            " no menu

"" OS specific settings
if $OS == "linux"
  set guifont=Anonymice\ Nerd\ Font\ 14
endif

if $OS == "osx"
  set guifont=Anonymice\ Nerd\ Font\ Complete:h14
  set fuoptions=maxvert,maxhorz      " use whole screen in fullscreen mode
  " keybindings a'la tpope/vim-unimpaired
  nmap cof :set fullscreen! fullscreen?<CR>
  nmap [of :set fullscreen<CR>
  nmap ]of :set nofullscreen<CR>
endif

if has('win32')
  set guifont=Anonymice_NF:h12:cDEFAULT:qCLEARTYPE
endif
