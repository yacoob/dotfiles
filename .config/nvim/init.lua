-- install lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins via lazy
require('lazy').setup({
  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true},
  'hiphish/rainbow-delimiters.nvim',
  {'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {}},
  {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
  {'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
  'nvim-treesitter/nvim-treesitter',
--[[
'brooth/far.vim'                      " find&replace on steroids
'gregsexton/gitv'                     " gitk in vim
'inside/vim-search-pulse'             " pulse current line after search
'junegunn/limelight.vim'              " dim syntax in other parts of the file
'justinmk/vim-sneak'                  " middle ground between f and /
'kana/vim-narrow'                     " emacs-style narrowing
'lilydjwg/colorizer'                  " sets background under color definitions
'majutsushi/tagbar'                   " tagbar
'mbbill/undotree'                     " undo tree visualisation
'mhinz/vim-signify'                   " vcs modification marks
'Raimondi/delimitMate'                " auto-closing of quotes, parenthesis and brackets
'regedarek/ZoomWin'                   " toggle between single/multi window
'terryma/vim-expand-region'           " quick selection expansion for visual mode
'tpope/vim-commentary'                " quick comment out/in
'tpope/vim-fugitive'                  " git integration
'tpope/vim-surround'                  " quick 'surrounds' editing
'tpope/vim-unimpaired'                " various navigation and convenience toggles
'Valloric/ListToggle'                 " quick toggle for location and quickfist lists
'vasconcelloslf/vim-interestingwords' " arbitrary phrase highlighter
'vim-airline/vim-airline-themes'      " airline themes
'vim-scripts/CursorLineCurrentWindow' " current line highlight only in active buffer
'vim-scripts/gitignore'               " merge .gitignore into wildignore
'yuttie/comfortable-motion.vim'       " intertial scrolling
--]]
})
-- activate plugins
require('lualine').setup()


-- nvim options
--
-- whitespace
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {tab = '| ', trail = '·', extends = '»', precedes = '«'}
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- ui
vim.opt.clipboard:append('unnamedplus')
vim.opt.cursorline = true
vim.opt.guifont = 'FiraCode Nerd Font Mono Retina:h15'
-- searching
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.matchpairs:append('<:>')
vim.opt.showmatch = true
vim.opt.smartcase = true


-- colors
vim.opt.background = 'dark'
require('gruvbox').setup({
  invert_intend_guides = true,
  contrast = 'hard',
})
vim.cmd('colorscheme gruvbox')
