---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    ensure_installed = {
      -- the bare minimum, TSInstall will fetch others as needed
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
