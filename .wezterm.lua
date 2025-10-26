local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/opt/homebrew/bin/fish", "-l" } -- "/usr/bin/fish"

config.color_scheme = "One Light (base16)"

config.font = wezterm.font_with_fallback({
	"JetBrains Mono", -- Primary font for text
	"Hack Nerd Font", -- Fallback font for icons
	"Symbols Nerd Font Mono", -- Another fallback for symbols and icons
})

config.font_size = 12.5
config.harfbuzz_features = { "calt=0", "clig=0", "liga=1" }

config.set_environment_variables = {
	EDITOR = "nvim",
}

return config
