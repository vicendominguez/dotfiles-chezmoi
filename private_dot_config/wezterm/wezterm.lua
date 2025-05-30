local wezterm = require 'wezterm'

return {
  -- Font: use your preferred Nerd Font
  font = wezterm.font_with_fallback {
    "SpaceMono Nerd Font",
    "Monospace"
  },
  font_size = 12.0,

  -- Appearance
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = 'Chameleon (Gogh)',
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  -- Window style
  window_decorations = "RESIZE",
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  window_close_confirmation = "NeverPrompt",
  initial_rows = 20,
  initial_cols = 90,
  -- Performance
  front_end = "WebGpu",
  animation_fps = 60,
  max_fps = 120,

  -- Keybindings for pane splitting
  keys = {
    {
      key = "Enter",
      mods = "ALT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "Enter",
      mods = "ALT|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
  },

  scrollback_lines = 5000,
  check_for_updates = false,
  audible_bell = "Disabled",
}
