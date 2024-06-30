-- bootstrap AstroNvim via Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  {
    'AstroNvim/AstroNvim',
    version = '^4',
    import = 'astronvim.plugins',
    opts = {
      mapleader = ' ',
      maplocalleader = ',',
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  { import = 'plugins' }, -- load local plugin configs
} --[[@as LazySpec]], {
  install = { colorscheme = { 'astrodark' } },
  ui = { backdrop = 100 },
} --[[@as LazyConfig]])
