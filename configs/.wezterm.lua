local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.color_scheme = "One Light (base16)"

return config
