-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- autocommands
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
          {
            event = { "FileType" },
            pattern = { "beancount" },
            desc = "Explicitly disable AstroNvim large buffer check for specific filetypes",
            callback = function(args)
              vim.b[args.buf].large_buf = false
              require("astrocore").event("LargeBuf", true)
            end,
          },
        },
      },

    -- vim options
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

    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
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
  },
}
