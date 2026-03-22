-- Create augroup
local yacoob_group = vim.api.nvim_create_augroup("yacoob", { clear = true })

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = yacoob_group,
  desc = "Strip trailing whitespace on save",
  command = ":%s/\\s\\+$//e",
})
