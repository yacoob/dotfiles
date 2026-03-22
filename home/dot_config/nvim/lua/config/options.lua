-- whitespace
vim.opt.list = true -- highlight some special characters
vim.opt.listchars = { tab = "| ", trail = "·", extends = "»", precedes = "«" }

-- searching
vim.opt.gdefault = true -- g flag by default for :s
vim.opt.matchpairs = "[:],(:),{:},<:>" -- add < and > to list of matching brackets
vim.opt.showmatch = true -- flash matching bracket

-- ui
vim.opt.guifont = "FiraCode Nerd Font:h14"
vim.opt.scrolloff = 14 -- leave this amount of lines while scrolling up/down
vim.opt.winblend = 10 -- transparency for floating window
vim.opt.pumblend = 10 -- transparency for popup menu

-- behavioral
vim.opt.autowrite = true -- auto-write file before certain operations
vim.opt.keymodel = "startsel" -- shift+special key = selection
vim.opt.cmdheight = 1 -- no more "press enter prompts" for one line outputs

-- vim.g settings (equivalent to AstroCore's opts.g)
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
