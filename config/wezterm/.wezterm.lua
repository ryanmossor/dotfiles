local wezterm = require("wezterm")
local act = wezterm.action
local vim_edit_scrollback = require("vim_edit_scrollback")

local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

local config = wezterm.config_builder()
config.term = "xterm-256color"
config.color_scheme = "Catppuccin Mocha"
config.window_close_confirmation = "AlwaysPrompt"

-- default window size
config.initial_cols = 100
config.initial_rows = 30

-- key bindings
local mod = "CTRL|SHIFT"
config.keys = {
	{ key = "w", mods = mod, action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "v", mods = mod, action = act.PasteFrom("Clipboard") },
	-- { key = 'v', mods = mod, action = act.PasteFrom 'PrimarySelection' },
	{ key = "C", mods = mod, action = act.ActivateCopyMode },
	{ key = "e", mods = mod, action = wezterm.action_callback(vim_edit_scrollback) },
}

-- Ctrl+1 for tab 1, Ctrl+2 for tab 2, etc.
for i = 1, 9 do
	table.insert(config.keys, { key = tostring(i), mods = "CTRL", action = act.ActivateTab(i - 1) })
end

config.mouse_bindings = {
	{
		-- click to open links w/ no modifier key
		event = { Up = { streak = 1, button = "Left" } },
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- font
--local font_list = { "CaskaydiaMono NF", "Cascadia Mono", "Ubuntu Mono" }
local font_list = { "Cascadia Mono", "Ubuntu Mono" }
config.font_size = 16

-- if is_mac then
-- 	table.insert(font_list, 1, 'Consolas')
-- end

config.font = wezterm.font_with_fallback(font_list)

local default_opacity = 0.90
if is_windows then
	config.default_prog = { "wsl.exe", "~" }
	default_opacity = 1.0

	table.insert(config.keys, {
		key = "p",
		mods = "ALT",
		action = act.SpawnCommandInNewTab({ args = { "powershell.exe", "-NoLogo" } }),
	})
else
	config.window_background_opacity = default_opacity
	table.insert(config.keys, { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("toggle-opacity") })
end

wezterm.on("toggle-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if overrides.window_background_opacity == 1.0 then
		overrides.window_background_opacity = default_opacity
	else
		overrides.window_background_opacity = 1.0
	end
	window:set_config_overrides(overrides)
end)

config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

return config
