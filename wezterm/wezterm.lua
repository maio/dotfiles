-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- (This is where our config will go)
config.color_scheme = 'DoomOne'
config.font_size = 18
config.window_decorations = 'RESIZE'


config.keys = {
  { key = 'i', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'k', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1) },
}

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config

