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

-- add a host-specific config if it exists
local hostname = vim.fn.hostname()
local hostconfig = vim.fn.stdpath 'config' .. '/lua/host/' .. hostname .. '.lua'
if (vim.uv or vim.loop).fs_stat(hostconfig) then
  table.insert(spec, { import = 'host.' .. hostname})
end

-- source a "devenv host"'s config if we're running in a devpod
local devenv_config = vim.fn.stdpath 'config' .. '/lua/host/devenv.lua'
if vim.env.DEVPOD == 'true' and (vim.uv or ivm.loop).fs_stat(devenv_config) then
  table.insert(spec, { import = 'host.devenv'})
end

-- run Lazy
vim.opt.rtp:prepend(lazypath)
require('lazy').setup(spec,
{
  install = { colorscheme = { 'tokyonight-night' } },
  ui = { backdrop = 100 },
} --[[@as LazyConfig]])
