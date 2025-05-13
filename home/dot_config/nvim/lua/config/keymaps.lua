local wk = require("which-key")

-- forgot your sudo?
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { desc = "sudo write :3" })

-- Insert mode abbreviations
vim.keymap.set("ia", "---", "—")
vim.keymap.set("ia", "dts", 'strftime("%Y-%m-%d")', { expr = true })

-- moving whole lines
vim.keymap.set("n", "<A-k>", "ddkP")
vim.keymap.set("n", "<A-j>", "ddp")
vim.keymap.set("v", "<A-k>", "xkP`[V`")
vim.keymap.set("v", "<A-j>", "xp`[V`]")

-- my convenience shortcuts
wk.add({ { "<Leader>Y", group = "yacoob shortcuts", icon = "󱚥" } })
vim.keymap.set("n", "<Leader>Yc", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file's path" })
