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

function bindKey(keys, description, command)
    hl.unbind(keys)
    o.bind(keys, description, command)
end

-- System
bindKey("ALT + SPACE", "App launcher", "omarchy-menu")
bindKey("SUPER + PERIOD", "Emojis", "omarchy-shell shell toggle omarchy.emojis")
bindKey("SUPER + Escape", "System menu", "omarchy-menu summon system")
bindKey("SUPER + SHIFT + I", "Install Package", "xdg-terminal-exec --app-id=org.omarchy.terminal omarchy-pkg-install")
bindKey("SUPER + SHIFT + CTRL + I", "Install AUR Package",
    "xdg-terminal-exec --app-id=org.omarchy.terminal omarchy-pkg-aur-install")
-- bindKey("SUPER + SHIFT + PERIOD", "Lock & suspend", "omarchy-system-lock; systemctl suspend")
hl.unbind("SUPER + SHIFT + SPACE")

-- bindKey("SUPER + SHIFT + S", "Screenshot", "flameshot gui")
bindKey("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")
bindKey("SUPER + SHIFT + CTRL + S", "Extract text (OCR) from screenshot", "omarchy-capture-text")

-- Hyprland
bindKey("SUPER + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bindKey("SUPER + F11", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bindKey("SUPER + W", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
bindKey("SUPER + Q", "Close window", hl.dsp.window.close())
bindKey("SUPER + Z", "Zen mode", "omarchy-hyprland-window-single-square-aspect-toggle")
bindKey("SUPER + SHIFT + R", "Reload Hyprland config", "hyprctl reload")

-- Media controls
bindKey("SHIFT + F8", "Play/pause", "omarchy-shell media playPause")
bindKey("SHIFT + F9", "Volume down", "omarchy-audio-output-volume lower")
bindKey("SHIFT + F10", "Volume up", "omarchy-audio-output-volume raise")
bindKey("SHIFT + F11", "Mute toggle", "omarchy-audio-output-volume mute-toggle")

-- Application launchers
bindKey("SUPER + D", "Docker", { tui = "omarchy-launch-docker-tui" })
bindKey("SUPER + E", "File manager", { omarchy = "nautilus" })
bindKey("SUPER + L", "LocalSend", { launch = "localsend" })
bindKey("SUPER + N", "Joplin", "$HOME/.joplin/Joplin.AppImage")
bindKey("SUPER + P", "Scrcpy", "scrcpy")
bindKey("SUPER + T", "Terminal", { omarchy = "terminal" })
bindKey("SUPER + B", "Browser", { omarchy = "browser" })
bindKey("SUPER + ALT + B", "Browser (incognito)", { omarchy = "browser --private" })
bindKey("SUPER + SHIFT + B", "Bitwig Studio", "bitwig-studio")
bindKey("SUPER + ALT + C", "Calculator", "omacalc")
bindKey("SUPER + SHIFT + C", "Color picker", "pkill hyprpicker || hyprpicker -a")
bindKey("SUPER + SLASH", "Bitwarden", { omarchy = "bitwarden" })
bindKey("SUPER + SHIFT + SLASH", "1password", { omarchy = "1password" })

-- Web apps
bindKey("SUPER + M", "Spotify", { webapp = "https://open.spotify.com/" })
bindKey("SUPER + Y", "YouTube", { webapp = "https://www.youtube.com/" })
bindKey("SUPER + A", "ChatGPT", { webapp = "https://chatgpt.com/" })
bindKey("SUPER + G", "Grok", { webapp = "https://www.grok.com/" })
bindKey("SUPER + SHIFT + X", "Perplexity", { webapp = "https://www.perplexity.ai/" })
bindKey("SUPER + SHIFT + D", "Discord", { webapp = "https://discord.com/channels/@me" })
bindKey("SUPER + SHIFT + H", "Home Assistant", { webapp = "http://192.168.0.55:8123/lovelace/default_view" })

bindKey(
    "SUPER + SHIFT + W",
    "Work apps (Outlook, Teams, Slack)",
    [[bash -c 'hyprctl dispatch workspace 8; brave --app=https://outlook.office365.com/mail & brave --app=https://teams.microsoft.com/l/chat/0/0 & brave --app=https://copeland-software.slack.com &']]
)
