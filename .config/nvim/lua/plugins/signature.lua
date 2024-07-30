---@type LazySpec
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      always_trigger = false,
      hint_enable = true,
      hint_prefix = "😼 ",
      hi_parameter = "IncSearch",
      toggle_key = "<C-k>",
      move_cursor_key = "<M-p>",
      select_signature_key = "<M-n>",
    }, bufnr)
  end,
})

return {
  "ray-x/lsp_signature.nvim",
  event = "User AstroFile",
  main = "lsp_signature",
  -- opts = {
  -- },
  specs = {
    {
      "folke/noice.nvim",
      optional = true,
      ---@type NoiceConfig
      opts = {
        lsp = {
          signature = { enabled = false },
          hover = { enabled = false },
        },
      },
    },
  },
}
