--—@type LazySpec
return {
  "mason-org/mason.nvim",
  --—@type MasonSettings
  opts = {
    -- add Mason bin path at the end of PATH, so the locally installed tools take precedence
    PATH = "append",
  },
}
