-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      'diff',
      'gitattributes',
      'gitcommit',
      'git_config',
      'gitignore',
      'git_rebase',
      'lua',
      'markdown',
      'markdown_inline',
      'vim',
    },
  },
}
