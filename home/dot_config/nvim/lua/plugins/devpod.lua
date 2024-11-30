local ac = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
}

if os.getenv("DEVPOD") then
  vim.list_extend(ac, {
    { import = "astrocommunity.editing-support.nvim-devdocs" },
    { import = "astrocommunity.test.neotest" },
    { import = "astrocommunity.test.nvim-coverage" },
  })

  local flavour = os.getenv("DEVPOD_FLAVOUR")

  if flavour == "python" then
    vim.list_extend(ac, {
      { import = "astrocommunity.pack.python-ruff" },
    })
  end
end

return ac
