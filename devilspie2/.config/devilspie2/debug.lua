debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name())
debug_print("Window class: " .. get_window_class())

function contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

