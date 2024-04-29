local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_linux = wezterm.target_triple:find('linux') ~= nil
local is_mac = wezterm.target_triple:find('darwin') ~= nil
local is_windows = wezterm.target_triple:find('windows') ~= nil

config.color_scheme = 'Catppuccin Mocha'
    
-- default window size
config.initial_cols = 100
config.initial_rows = 30

-- key bindings
config.keys = {
    { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'PrimarySelection' }, 
}

-- font
config.font = wezterm.font_with_fallback {
    'Cascadia Code',
    'Ubuntu Mono',
}
config.font_size = 12

if (is_mac) then
    config.font_size = 16
end

config.launch_menu = {}

if (is_windows) then
    config.default_prog = { 'wsl.exe', '~' }

    table.insert(config.launch_menu, {
        label = 'PowerShell',
        args = { 'powershell.exe', '-NoLogo' },
    })
    table.insert(config.launch_menu, {
        label = 'Ubuntu',
        args = { 'wsl.exe', '~' },
    })

    table.insert(config.keys, {
        key = 'p', mods = 'ALT', action = wezterm.action.SpawnCommandInNewTab { args = { 'powershell.exe', '-NoLogo' } },
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.window_close_confirmation = 'NeverPrompt'

return config
