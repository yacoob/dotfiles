local wezterm = require 'wezterm'
local config = {
  -- appearance
  use_fancy_tab_bar = false,
  font = wezterm.font('FiraCode Nerd Font'),
  color_scheme = 'tokyonight_night',

  -- behaviour
  window_close_confirmation = 'NeverPrompt',
  skip_close_confirmation_for_processes_named = { 'bash', 'flatpak-spawn', 'zsh' },

  -- default shell
  default_prog = {"/usr/bin/zsh", "-l"},
}
return config
