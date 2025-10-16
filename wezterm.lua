local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
	window_padding = {
		bottom = 0,
	},
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Tokyo Night",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 15,
}

return config
