-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- vim.api.nvim_create_autocmd(event, opts)

--[[
  ruff is really good, but so far it still can't sort imports before file save
  astrocommunity.pack.python-ruff explicitly removes isort from ensure_installed
  my options were either an autocommand or bringing back isort
  I went with an autocommand, to make sure it's ruff doing the isorting, so if I
  need to configure things, I don't need a separate cfg file for isort
  https://github.com/astral-sh/ruff-lsp/issues/95
]]
vim.api.nvim_create_augroup("yacoob", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py" },
  group = "yacoob",
  desc = "sort python imports",
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    vim.wait(100)
  end,
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = "yacoob",
  desc = "strip trailing whitespace on save",
  command = ":%s/\\s\\+$//e",
})
