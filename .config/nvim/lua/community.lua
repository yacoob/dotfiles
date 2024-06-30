-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  'AstroNvim/astrocommunity',
  { import = 'astrocommunity.editing-support.rainbow-delimiters-nvim' },
  { import = 'astrocommunity.editing-support.wildfire-nvim' },
  { import = 'astrocommunity.git.neogit' },
  { import = 'astrocommunity.git.diffview-nvim' },
  { import = 'astrocommunity.pack.markdown' },
  { import = 'astrocommunity.pack.python-ruff' },
  { import = 'astrocommunity.recipes.telescope-lsp-mappings' },
}
