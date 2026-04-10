local M = {}

local setup_keybindings = function()
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        shortcut = "<leader>draw",
        mapper_cmd_OR_function = ":Paint<CR>",
        desc = "draw some stuff",
        mode = "n"
      }
    }
  }
end

--- @param opts table
M.setup = function(opts)
  require("paint").setup(opts)
  setup_keybindings()
end

return M
