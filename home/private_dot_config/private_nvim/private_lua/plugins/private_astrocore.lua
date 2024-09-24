return {
	{
		"AstroNvim/astrocore",
		---@type AstroCoreOpts
		opts = {
			autocmds = {
				yacoob = {
					{
						event = { "BufWritePre" },
						desc = "Strip trailing whitespace on save",
						command = ":%s/\\s\\+$//e",
					},
					{
						event = { "FileType" },
						pattern = { "beancount" },
						desc = "Explicitly disable AstroNvim large buffer check for specific filetypes",
						callback = function(args)
							vim.b[args.buf].large_buf = false
							require("astrocore").event("LargeBuf", true)
						end,
					},
					-- ruff is really good, but so far it still can't sort imports before file save
					-- astrocommunity.pack.python-ruff explicitly removes isort from ensure_installed
					-- my options were either an autocommand or bringing back isort
					-- I went with an autocommand, to make sure it's ruff doing the isorting, so if I
					-- need to configure things, I don't need a separate cfg file for isort
					-- https://github.com/astral-sh/ruff-lsp/issues/95
					{
						event = { "BufWritePre" },
						pattern = { "*.py" },
						desc = "Sort python imports",
						callback = function()
							vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
							vim.wait(100)
						end,
					},
				},
			},
			options = {
				opt = {
					-- -- whitespace
					list = true, -- highlight some special characters
					listchars = { tab = "| ", trail = "·", extends = "»", precedes = "«" },
					-- searching
					gdefault = true, -- g flag by default for :s
					matchpairs = "[:],(:),{:},<:>", -- add < and > to list of matching brackets
					showmatch = true, -- flash matching bracket
					-- ui
					guifont = "FiraCode Nerd Font:h14",
					scrolloff = 14, -- leave this amount of lines while scrolling up/down
					winblend = 10, -- transparency for floating window
					pumblend = 10, -- transparency for popup menu
					-- behavioral
					autowrite = true, -- auto-write file before certain operations
					keymodel = "startsel", -- shift+special key = selection
					cmdheight = 1, -- no more "press enter prompts" for one line outputs
				},
				g = {
					loaded_perl_provider = 0,
					loaded_python3_provider = 0,
					loaded_ruby_provider = 0,
					loaded_node_provider = 0,
				},
			},
			mappings = {
				-- command mode
				c = {
					-- forgot your sudo?
					["w!!"] = { "w !sudo tee % >/dev/null", desc = "sudo write :3" },
				},
				-- abbreviations
				ia = {
					["---"] = { "—" },
					["dts"] = { 'strftime("%Y-%m-%d")', expr = true },
				},
				-- normal mode
				n = {
					-- moving whole lines
					["<A-k>"] = { "ddkP" },
					["<A-j>"] = { "ddp" },
					-- my convenience shortcuts
					["<Leader>Y"] = { name = "yacoob shortcuts" },
					["<Leader>Yc"] = { ":cd %:p:h<CR>:pwd<CR>", desc = "cd to current file's path" },
					-- plugin shortcuts
					["<Leader>gnt"] = { ":Neogit kind=split<CR>", desc = "Open Neogit in a split above" },
				},
				-- visual mode
				v = {
					-- moving whole lines
					["<A-k>"] = { "xkP`[V`" },
					["<A-j>"] = { "xp`[V`]" },
				},
			},
			diagnostics = {
				virtual_text = {
					virt_text_pos = "right_align",
					suffix = " ",
				},
			},
		},
	},
}
