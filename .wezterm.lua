local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Set default program (optional)
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- Set the color scheme
config.color_scheme = "One Light (base16)" -- Customize as needed

-- Use JetBrains Mono for text, and a Nerd Font for icons and symbols
config.font = wezterm.font_with_fallback({
	"JetBrains Mono", -- Primary font for text
	"Hack Nerd Font", -- Fallback font for icons (you can choose another Nerd Font)
	"Symbols Nerd Font Mono", -- Another fallback for symbols and icons
})

-- Set font size
config.font_size = 12.5 -- Adjust as necessary

-- Enable ligatures (optional)
config.harfbuzz_features = { "calt=0", "clig=0", "liga=1" }

return config
