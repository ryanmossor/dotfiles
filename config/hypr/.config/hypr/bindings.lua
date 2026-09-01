-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")

-- function bindKey(keys, description, command)
--     hl.unbind(keys)
--     o.bind(keys, description, command)
-- end

-- Hyprland
o.bind("SUPER + SHIFT + SPACE", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + F11", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + W", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + Z", "Zen mode", "omarchy-hyprland-window-single-square-aspect-toggle")
o.bind("SUPER + SHIFT + R", "Reload Hyprland config", "hyprctl reload")

o.bind("SUPER + LEFT", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + RIGHT", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + UP", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + DOWN", "Focus on below window", hl.dsp.focus({ direction = "d" }))

for workspace = 1, 10 do
    local key = "code:" .. tostring(workspace + 9)
    o.bind(
        "SUPER + " .. key,
        "Switch to workspace " .. workspace,
        hl.dsp.focus({ workspace = tostring(workspace) }))
    o.bind(
        "SUPER + SHIFT + " .. key,
        "Move window to workspace " .. workspace,
        hl.dsp.window.move({ workspace = tostring(workspace) }))
end

o.bind("SUPER + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))

o.bind("SUPER + SHIFT + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

o.bind("SUPER + mouse:272", "Move window", hl.dsp.window.drag(), { mouse = true })     -- LMB
o.bind("SUPER + mouse:273", "Resize window", hl.dsp.window.resize(), { mouse = true }) -- RMB

-- System
o.bind("ALT + SPACE", "App launcher", "omarchy-menu")
o.bind("SUPER + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + PERIOD", "Emojis", "omarchy-shell shell toggle omarchy.emojis")
o.bind("SUPER + Escape", "System menu", "omarchy-menu summon system")
o.bind("SUPER + SHIFT + I", "Install Package", "xdg-terminal-exec --app-id=org.omarchy.terminal omarchy-pkg-install")
o.bind("SUPER + SHIFT + CTRL + I", "Install AUR Package",
    "xdg-terminal-exec --app-id=org.omarchy.terminal omarchy-pkg-aur-install")
-- o.bind("SUPER + SHIFT + PERIOD", "Lock & suspend", "omarchy-system-lock; systemctl suspend")

-- o.bind("SUPER + SHIFT + S", "Screenshot", "flameshot gui")
o.bind("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")
o.bind("SUPER + SHIFT + CTRL + S", "Extract text (OCR) from screenshot", "omarchy-capture-text")

-- Media controls
o.bind("SHIFT + F8", "Play/pause", "omarchy-shell media playPause")
o.bind("SHIFT + F9", "Volume down", "omarchy-audio-output-volume lower")
o.bind("SHIFT + F10", "Volume up", "omarchy-audio-output-volume raise")
o.bind("SHIFT + F11", "Mute toggle", "omarchy-audio-output-volume mute-toggle")

-- Application launchers
o.bind("SUPER + D", "Docker", { tui = "omarchy-launch-docker-tui" })
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + L", "LocalSend", { launch = "localsend" })
o.bind("SUPER + N", "Joplin", "$HOME/.joplin/Joplin.AppImage")
o.bind("SUPER + P", "Scrcpy", "scrcpy")
o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + ALT + B", "Browser (incognito)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + B", "Bitwig Studio", "bitwig-studio")
o.bind("SUPER + ALT + C", "Calculator", "omacalc")
o.bind("SUPER + SHIFT + C", "Color picker", "pkill hyprpicker || hyprpicker -a")
o.bind("SUPER + SLASH", "Bitwarden", { omarchy = "bitwarden" })
o.bind("SUPER + SHIFT + SLASH", "1password", { omarchy = "1password" })

-- Web apps
o.bind("SUPER + M", "Spotify", { omarchy = "spotify" })
o.bind("SUPER + Y", "YouTube", { webapp = "https://www.youtube.com/" })
o.bind("SUPER + A", "ChatGPT", { webapp = "https://chatgpt.com/" })
o.bind("SUPER + G", "Grok", { webapp = "https://www.grok.com/" })
o.bind("SUPER + SHIFT + X", "Perplexity", { webapp = "https://www.perplexity.ai/" })
o.bind("SUPER + SHIFT + D", "Discord", { webapp = "https://discord.com/channels/@me" })
o.bind("SUPER + SHIFT + H", "Home Assistant", { webapp = "http://192.168.0.55:8123/lovelace/default_view" })

o.bind(
    "SUPER + SHIFT + W",
    "Work apps (Outlook, Teams, Slack)",
    [[bash -c 'hyprctl dispatch workspace 8; brave --app=https://outlook.office365.com/mail & brave --app=https://teams.microsoft.com/l/chat/0/0 & brave --app=https://copeland-software.slack.com &']]
)
