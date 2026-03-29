local opt = vim.opt

-- whitespace
opt.list = true -- highlight some special characters
opt.listchars = { tab = "| ", trail = "·", extends = "»", precedes = "«" }

-- searching
opt.gdefault = true -- g flag by default for :s
opt.matchpairs = "[:],(:),{:},<:>" -- add < and > to list of matching brackets
opt.showmatch = true -- flash matching bracket

-- ui
opt.guifont = "FiraCode Nerd Font:h14"
opt.scrolloff = 14 -- leave this amount of lines while scrolling up/down
opt.winblend = 10 -- transparency for floating window
opt.pumblend = 10 -- transparency for popup menu

-- behavioral
opt.autowrite = true -- auto-write file before certain operations
opt.keymodel = "startsel" -- shift+special key = selection
opt.cmdheight = 1 -- no more "press enter prompts" for one line outputs

-- vim.g settings (equivalent to AstroCore's opts.g)
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- lazyvim settings
vim.g.root_spec = { "lsp", { ".jj", ".git", "lua" }, "cwd" }

-- lazyvim top-level lsp preferences
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"
