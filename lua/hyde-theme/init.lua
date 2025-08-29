local config = require("hyde-theme.config")

local M = {}

-- Apply detected theme (with fallback to "default")
function M.apply()
  local theme = config.detect_theme()
  local ok, err = pcall(vim.cmd.colorscheme, theme)
  if not ok then
    vim.notify(
      "HydeTheme: failed to load colorscheme '" .. theme .. "' → falling back to 'default'",
      vim.log.levels.WARN
    )
    vim.cmd.colorscheme("default")
  end
end

-- User setup
function M.setup(opts)
  opts = opts or {}

  -- Allow user to override mappings
  if opts.map then
    config.set_map(opts.map)
  end

  -- Apply once on startup
  M.apply()

  -- Optional auto-refresh polling
  if opts.autorefresh then
    vim.fn.timer_start(opts.interval or 60000, function()
      vim.schedule(M.apply)
    end, { ["repeat"] = -1 })
  end

  -- Add a manual command
  vim.api.nvim_create_user_command("HydeTheme", function()
    M.apply()
  end, { desc = "Apply theme based on current GTK settings" })
end

return M

-- vim: set ft=lua ts=2 sw=2 et :
