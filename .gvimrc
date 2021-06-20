"" GUI specific settings
set guioptions-=T            " don't show toolbar
set guioptions-=m            " no menu

"" OS specific settings
if $FLAVOUR == "linux"
  set guifont=Fira\ Code\ 14
endif

"" In theory, this repo doesn't support being used with win10. In practice,
"" I reuse vim's config. :D
"" So: no FLAVOUR=win10, but win-specific code.
if has('win32')
  set guifont=FiraCode_NF:h12:cDEFAULT:qCLEARTYPE
  set renderoptions=type:directx,renmode:0,taamode:0
endif
