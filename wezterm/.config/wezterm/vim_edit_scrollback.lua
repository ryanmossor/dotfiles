local io = require 'io'
local os = require 'os'
local wezterm = require 'wezterm'
local act = wezterm.action

function vim_edit_scrollback(window, pane)
    local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

    local name = os.tmpname()
    local f = io.open(name, 'w+')
    f:write(text)
    f:flush()
    f:close()

    window:perform_action(act.SpawnCommandInNewWindow { args = { 'vim', name } }, pane)
end

return vim_edit_scrollback 
