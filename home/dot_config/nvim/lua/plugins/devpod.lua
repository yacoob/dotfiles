local ac = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.editing-support.nvim-devdocs" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.test.nvim-coverage" },
}

if os.getenv("DEVPOD") then
  local imports = os.getenv("DEVPOD_NVIM_ASTROCOMMUNITY")
  if imports then
    for i in string.gmatch(imports, "[^, ]+") do
      if string.match(i, "^[A-Za-z-.]+$") then
        vim.list_extend(ac, {
          {
            import = string.find(i, ".", 1, true) and "astrocommunity." .. i or "astrocommunity.pack." .. i,
          },
        })
      end
    end
  end
end

return ac
