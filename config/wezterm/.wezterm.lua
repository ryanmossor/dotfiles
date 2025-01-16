local wezterm = require("wezterm")
local act = wezterm.action
local vim_edit_scrollback = require("vim_edit_scrollback")

local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

local config = wezterm.config_builder()
config.term = "xterm-256color"

local catppuccin_mocha = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
catppuccin_mocha.tab_bar = {
	background = catppuccin_mocha.tab_bar.background,

	active_tab = {
		bg_color = "#89b4fa",
		fg_color = "#11111b",
		intensity = "Normal", -- "Half", "Normal", or "Bold"
	},

	inactive_tab = {
		bg_color = catppuccin_mocha.tab_bar.background,
		fg_color = "#7f849c",
		intensity = "Normal",
	},

	inactive_tab_hover = catppuccin_mocha.tab_bar.inactive_tab_hover,

	new_tab = {
		bg_color = "#1b1032",
		fg_color = "#808080",
	},

	new_tab_hover = catppuccin_mocha.tab_bar.new_tab_hover,
}

config.color_schemes = {
	["Catppuccin Mocha"] = catppuccin_mocha,
}

config.color_scheme = "Catppuccin Mocha"

config.window_close_confirmation = "AlwaysPrompt"

-- default window size
config.initial_cols = 100
config.initial_rows = 30

-- key bindings
local mod = is_mac and "CMD|SHIFT" or "CTRL|SHIFT"
local ctrl = is_mac and "CMD" or "CTRL"

config.keys = {
	{ key = "w", mods = mod, action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "v", mods = mod, action = act.PasteFrom("Clipboard") },
	-- { key = 'v', mods = mod, action = act.PasteFrom 'PrimarySelection' },
	{ key = "c", mods = mod, action = act.ActivateCopyMode },
	{ key = "e", mods = mod, action = wezterm.action_callback(vim_edit_scrollback) },
	{ key = "t", mods = mod, action = act.SpawnTab "CurrentPaneDomain" },
}

-- Ctrl+1 for tab 1, Ctrl+2 for tab 2, etc.
for i = 1, 9 do
	table.insert(config.keys, { key = tostring(i), mods = "CTRL", action = act.ActivateTab(i - 1) })
end

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = ctrl,
        action = act.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection"),
    },
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- font
config.font = wezterm.font_with_fallback({ "JetBrains Mono NL Medium", "Cascadia Mono", "Ubuntu Mono" })
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable font ligatures
config.font_size = 16

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
	table.insert(config.keys, { key = "o", mods = mod, action = wezterm.action.EmitEvent("toggle-opacity") })
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

config.max_fps = 120

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local format_str = "%s:%s"

	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	if has_unseen_output then
        format_str = format_str .. "*"
	end

	if tab.is_active then
        format_str = "[" .. format_str .. "]"
	end

	return {
		{ Text = " " .. string.format(format_str, tab.tab_index + 1, tab_title(tab)) .. " " },
	}
end)

return config
