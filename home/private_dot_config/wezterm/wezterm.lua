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
  default_prog = {'/usr/bin/zsh', '-l'},

  -- custom programs
  launch_menu = {
    {
      label = 'illaoi.normally.works',
      args = { 'ssh', '-A', 'illaoi' },
    },
    {
      label = 'tentakl.normally.works',
      args = { 'ssh', '-A', 'tentakl' },
    },
    {
      label = 'ye olde bash',
      args = { '/usr/bin/bash', '-l'},
    }
  },
  keys = {
    {
      key = 's', mods = 'ALT',
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' },
    },
  },
}
return config
