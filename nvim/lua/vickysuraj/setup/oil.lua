local M = {}

M.setup = function(opts)
  require("oil").setup(opts)
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = opts.shortcuts
  }
end

return M
