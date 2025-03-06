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
      local color_scheme = require("vickysuraj.mappings.color_scheme");
      vim.keymap.set("n", "<leader>pine", function()
        color_scheme.ColorMyBash("rose-pine")
      end)
      vim.keymap.set("n", "<leader>cs", function()
        color_scheme.randomColorSchema()
      end)
      color_scheme.ColorMyBash("tokyonight-storm")
    end
  }
}
