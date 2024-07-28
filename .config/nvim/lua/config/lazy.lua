local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Add LazyVim to plugin spec
local plugin_spec = {
  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-night" }, import = "lazyvim.plugins" },
  -- import/override with your plugins
  { import = "plugins" },
}

-- add a host-specific config if it exists
local hostname = vim.fn.hostname()
local hostconfig = vim.fn.stdpath("config") .. "/lua/host/" .. hostname .. ".lua"
if (vim.uv or vim.loop).fs_stat(hostconfig) then
  table.insert(plugin_spec, { import = "host." .. hostname })
end

require("lazy").setup({
  spec = plugin_spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- 'matchit',
        -- 'matchparen',
        -- 'netrwPlugin',
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})