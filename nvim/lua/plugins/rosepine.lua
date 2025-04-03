-- color schema ROSEPINE
return {
  {
    'rose-pine/neovim',
    dependencies = {
      {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
      }
    },
    name = 'rose-pine',
    config = function()
      local color_scheme = require("vickysuraj.setup.color_scheme");
      require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
        {
          mode = "n",
          shortcut = "<leader>cs",
          mapper_cmd_OR_function = function ()
            color_scheme.randomColorSchema()
          end,
          desc = "random color schema"
        },
        {
          mode = "n",
          shortcut = "<leader>pine",
          mapper_cmd_OR_function = function ()
            color_scheme.ColorMyBash("rose-pine")
          end,
          desc = "rose-pine color schema"
        }
      }
      color_scheme.ColorMyBash(require("config").default_theme)
    end
  }
}
