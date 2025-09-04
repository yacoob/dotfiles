return {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = {
      devpod = {
         docker_binary = "podman",
      },
      client_callback = function(port, _)
         local nvim_client='nvim --server localhost:%s --remote-ui'
         if vim.fn.executable('neovide') == 1 then
            nvim_client='neovide --server localhost:%s'
         end
         require("remote-nvim.ui").float_term((nvim_client):format(port), function(exit_code)
            if exit_code ~= 0 then
            vim.notify(("Local client failed with exit code %s"):format(exit_code), vim.log.levels.ERROR)
            end
         end)
      end,
   },
}
