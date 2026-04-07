return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.env.HOME .. "/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
