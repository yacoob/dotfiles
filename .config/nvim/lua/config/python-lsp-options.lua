-- Prioritize .venv directory for root directory determination. This find the
-- right root dir for monorepos, where you have multiple pyproject.toml files in
-- different subdirs and one virtualenv for them in an ascendant dir.
local rp = require("lspconfig.util").root_pattern
local pyright_root_files =
  { ".venv", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" }
local ruff_root_files = { ".venv", "pyproject.toml", "ruff.toml", ".ruff.toml" }

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      basedpyright = {
        root_dir = function(fname)
          return rp(unpack(pyright_root_files))(fname)
        end,
      },
      ruff = {
        root_dir = function(fname)
          return rp(unpack(ruff_root_files))(fname)
        end,
      },
    },
  },
}
