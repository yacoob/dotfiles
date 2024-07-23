return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- add border to the completion pop-up
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    -- disable selecting first position on the completion list
    -- opts.preselect = cmp.PreselectMode.None
    -- opts.completion = { completeopt = "menu,menuone,preview,noselect,noinsert" }
    -- opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --   ["<CR>"] = cmp.mapping.confirm({ select = false }),
    -- })
    return opts
  end,
}
