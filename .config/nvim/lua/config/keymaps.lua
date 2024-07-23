-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local wk = require("which-key")

-- command mode
map("c", "w!!", "w !sudo tee % >/dev/null", { desc = "sudo write :3" })
-- abbreviations
map("ia", "---", "—")
map("ia", "dts", 'strftime("%Y-%m-%d")', { expr = true })
-- normal mode
wk.add({
  { "<Leader>Y", group = "yacoob's shortcuts" },
  { "<Leader>Yc", ":cd %:p:h<CR>:pwd<CR>", desc = "cd to current file's path" },
})
