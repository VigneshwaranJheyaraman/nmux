require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      shortcut = "<leader>vu",
      mapper_cmd_OR_function = function()
        vim.cmd("DataViewer")
      end,
      desc = "show the CSV viewer floating",
      mode = "n"
    },
    {
      shortcut = "<leader>vc",
      mapper_cmd_OR_function = function()
        vim.cmd("DataViewerClose")
      end,
      desc = "close the CSV viewer floating",
      mode = "n"
    }
  }
}
