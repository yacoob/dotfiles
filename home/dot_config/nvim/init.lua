-- maybe add linuxbrew to PATH
local homebrew_path = '/home/linuxbrew/.linuxbrew'
if (vim.uv or vim.loop).fs_stat(homebrew_path) then
  vim.env.PATH = vim.env.PATH .. ':' .. homebrew_path .. '/bin'
end

-- install Lazy if it's not there
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath })
end

-- Add AstroNvim to plugin spec
local spec = {
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
  { import = 'plugins' },
} --[[@as LazySpec]]

-- run Lazy
vim.opt.rtp:prepend(lazypath)
require('lazy').setup(spec,
{
  install = { colorscheme = { 'tokyonight-night' } },
  ui = { backdrop = 100 },
} --[[@as LazyConfig]])
