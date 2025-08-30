local config = require("hyde_theme.config")

local M = {}

-- Expose detect_theme function
M.detect_theme = config.detect_theme

-- User setup
function M.setup(opts)
  opts = opts or {}

  -- Allow user to override mappings
  if opts.map then
    config.set_map(opts.map)
  end

  if opts.default then
    config.default = opts.default
  end
end

return M

-- vim: set ft=lua ts=2 sw=2 et :
