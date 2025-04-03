-- I handle all the DADBOD related configuration
vim.g.db_ui_dotenv_variable_prefix = 'DB_'
-- We currently opt the tpope/dotenv approach mentioned
-- https://github.com/kristijanhusak/vim-dadbod-ui?tab=readme-ov-file#databases ->> here
-- Since DB creds are more sensitive having them inside version control is not a guuudd idea.
-- Kindly prefix your ENVs of database connection with the format
-- ```bash
-- $ export DB_<ENV> = <DB_NAME>://<USER>:<PASSWORD>@<HOST>:<PORT>/<DB_NAME>
-- ```

-- default query saving location
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/queries"
-- donot execute on save its kind of annoying
vim.g.db_ui_execute_on_save = 0
-- use nerd fonts
vim.g.db_ui_use_nerd_fonts = 1

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  {
    mode = "n",
    shortcut = "<leader>odb",
    mapper_cmd_OR_function = function()
      -- opens the database ui
      vim.cmd("tabnew")
      vim.cmd("DBUI")
    end,
    desc = "Open Database neovim UI"
  },
  {
    mode = "n",
    shortcut = "<leader>cdb",
    mapper_cmd_OR_function = function()
      -- closes the database ui
      vim.cmd("tabclose")
    end,
    desc = "Close Database neovim UI"
  },
  {
    mode = "n",
    shortcut = "<leader>dbt",
    mapper_cmd_OR_function = function()
      vim.cmd("DBUIToggle")
    end,
    desc = "Toggle Database neovim UI"
  }

}
