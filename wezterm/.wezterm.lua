local wezterm = require 'wezterm'

return {
    color_scheme = 'Catppuccin Mocha',
    
    -- default window size
    initial_cols = 100,
    initial_rows = 30,

    -- key bindings
    keys = {
        { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
        { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
        { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'PrimarySelection' }, 
    },

    -- font
    font = wezterm.font_with_fallback {
        'Cascadia Mono',
        'Ubuntu Mono',
    },
    font_size = 12,

    -- tab bar
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
}
