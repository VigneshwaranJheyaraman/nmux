local mdown = require("render-markdown")

mdown.enable()

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      mode = "n",
      shortcut = "<leader>md",
      mapper_cmd_OR_function = function()
        mdown.buf_toggle()
      end
    },
    {
      mode = "n",
      shortcut = "<leader>vu",
      mapper_cmd_OR_function = function()
        if vim.fn.executable("open") then
          vim.cmd("!open -a \"Firefox\" %")
        end
      end
    }
  }
}
