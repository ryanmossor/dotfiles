function contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

if (get_window_class() == "firefox") then
  maximize()
  focus()
end

if (get_window_class() == "Code") then
  set_window_workspace(2)
  change_workspace(2)
  focus()
end

local gaming_apps = {
  "steam",
  "Cemu",
  "discord",
  "Slippi Launcher"
}

if (contains(gaming_apps, get_window_class())) then
  set_window_workspace(3)
  change_workspace(3)
  focus()
end

local writing_apps = {
  "obsidian",
  "Joplin",
  "LibreOffice 7.3",
  "ONLYOFFICE Desktop Editors" 
}

if (contains(writing_apps, get_window_class())) then
  set_window_workspace(4)
  change_workspace(4)
  maximize()
end

local media_apps = {
  "Spotify",
  "vlc" 
}

if (contains(media_apps, get_window_class())) then
  set_window_workspace(6)
  change_workspace(6)
  maximize()
  focus()
end

local config_apps = {
  "blueman-manager",
  "cinnamon-settings.py" 
}

if (contains(config_apps, get_application_name())) then
  set_window_workspace(7)
  change_workspace(7)
  focus()
end

if (get_application_name() == "virt-manager") then
  set_window_workspace(8)
  change_workspace(8)
  focus()
end
