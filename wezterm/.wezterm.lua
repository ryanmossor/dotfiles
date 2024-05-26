local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.window_close_confirmation = 'AlwaysPrompt'
config.window_background_opacity = 0.9
-- Removes window title bar; drag using title bar or Ctrl+Shift if only single tab
config.window_decorations = "RESIZE"
    
-- default window size
config.initial_cols = 100
config.initial_rows = 30

-- key bindings
config.keys = {
    { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = true } },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' }, 
    { key = 'C', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode }, 
}

-- Ctrl+1 for tab 1, Ctrl+2 for tab 2, etc.
for i = 1, 9 do
    table.insert(config.keys, { key = tostring(i), mods = 'CTRL', action = act.ActivateTab(i - 1) })
end

-- font
config.font = wezterm.font_with_fallback {
    'Cascadia Mono',
    'Ubuntu Mono',
}
config.font_size = 12

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

if (wezterm.target_triple:find('linux') ~= nil) then
end

if (wezterm.target_triple:find('darwin') ~= nil) then
    config.font_size = 16
end

if (wezterm.target_triple:find('windows') ~= nil) then
    config.default_prog = { 'wsl.exe', '~' }

    table.insert(config.keys, {
        key = 'p', mods = 'ALT', action = act.SpawnCommandInNewTab { args = { 'powershell.exe', '-NoLogo' } },
    })
end

return config
