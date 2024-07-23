-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.bigfile_size = 1024 * 1024 * 10
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.root_spec = { { ".venv" }, "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt
-- whitespace
opt.list = true
opt.listchars = { tab = "> ", trail = "·", extends = "»", precedes = "«" }
-- searching
opt.gdefault = true
opt.matchpairs = "[:],(:),{:},<:>"
opt.showmatch = true
-- ui
opt.guifont = "FiraCode Nerd Font:h14"
opt.scrolloff = 14 -- leave this amount of lines while scrolling up/down
opt.winblend = 20 -- transparency for floating window
opt.pumblend = 20 -- transparency for popup menu
-- behavioral
opt.cmdheight = 1 -- no more "press enter prompts" for one line outputs
opt.keymodel = "startsel" -- shift+special key = selection
