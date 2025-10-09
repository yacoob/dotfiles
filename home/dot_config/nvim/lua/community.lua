-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.chezmoi" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" },
}
