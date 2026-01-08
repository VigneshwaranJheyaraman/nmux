local M = {}

M.setup = function(_)
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        mode = "n",
        shortcut = "<leader>u",
        mapper_cmd_OR_function = vim.cmd.UndotreeToggle,
        desc = "open undotree"
      }
    }
  }
end

return M
