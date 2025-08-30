local M = {}

-- Default mapping from GTK theme names -> Neovim colorschemes
M.default_map = {
  ["Catppuccin-Mocha"] = "catppuccin",
  ["Catppuccin-Latte"] = "catppuccin",
  ["Rose-Pine"] = "rose-pine",
  ["Material-Sakura"] = "rose-pine",
  ["Tokyo-Night"] = "tokyonight-storm",
  ["Gruvbox-Retro"] = "gruvbox",
  ["Frosted-Glass"] = "modus",
  ["Nordic-Blue"] = "nordfox",
}

-- User custom mappings (filled in via setup)
M.user_map = {}

-- Allow user to extend or override mappings
function M.set_map(user_map)
  for k, v in pairs(user_map or {}) do
    M.user_map[k] = v
  end
end

-- Default value for default theme
M.default = "default"

-- Detect current GTK theme using gsettings
function M.detect_theme()
  local handle = io.popen("gsettings get org.gnome.desktop.interface gtk-theme")
  if not handle then
    return "default"
  end

  local content = handle:read("*a")
  handle:close()

  local gtk_theme = content and tostring(content):gsub("'", ""):gsub("\n", "") or nil

  return M.user_map[gtk_theme] or M.default_map[gtk_theme] or M.default or
  "default"                                                                         -- fallback: guaranteed built-in theme
end

return M
-- vim: set ft=lua ts=2 sw=2 et :
