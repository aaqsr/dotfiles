-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Stolen from Avish
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 11

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}

-- For example, changing the color scheme:
config.color_scheme = 'Afterglow'

-- and finally, return the configuration to wezterm
return config
