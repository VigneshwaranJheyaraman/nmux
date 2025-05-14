-- source the lua file
require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      mode= "n",
      shortcut = "<leader><leader>read",
      mapper_cmd_OR_function = "<cmd>source %<CR>",
      desc = "source the current LUA file as neovim config"
    }
  }
}
