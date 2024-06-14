local wezterm = require 'wezterm'
local act = wezterm.action
local vim_edit_scrollback = require 'vim_edit_scrollback'

local is_mac = wezterm.target_triple:find('darwin') ~= nil
local is_linux = wezterm.target_triple:find('linux') ~= nil
local is_windows = wezterm.target_triple:find('windows') ~= nil

local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.window_close_confirmation = 'AlwaysPrompt'

-- default window size
config.initial_cols = 100
config.initial_rows = 30

-- key bindings
config.keys = {
    { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = true } },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' }, 
    { key = 'C', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode }, 
    { key = 'e', mods = 'CTRL', action = wezterm.action_callback(vim_edit_scrollback) },
}

-- Ctrl+1 for tab 1, Ctrl+2 for tab 2, etc.
for i = 1, 9 do
    table.insert(config.keys, { key = tostring(i), mods = 'CTRL', action = act.ActivateTab(i - 1) })
end

-- font
config.font = wezterm.font_with_fallback { 'Cascadia Mono', 'Ubuntu Mono' }
config.font_size = 12

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

if (is_linux) then
end

if (is_mac) then
    config.font_size = 16
end

if (is_windows) then
    config.default_prog = { 'wsl.exe', '~' }

    table.insert(config.keys, {
        key = 'p', mods = 'ALT', action = act.SpawnCommandInNewTab { args = { 'powershell.exe', '-NoLogo' } },
    })
else
    config.window_background_opacity = 0.8
end

return config
