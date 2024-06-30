local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = 'Solarized Dark Higher Contrast (Gogh)'
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 9

return config
