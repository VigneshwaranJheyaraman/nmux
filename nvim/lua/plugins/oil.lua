return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
         dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function()
          require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = { show_hidden = true },
			})
            require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
              shortcuts = {
                {
                  mode = { "n", "v" },
                  shortcut = "<leader>pe",
                  mapper_cmd_OR_function = function()
                    vim.cmd("Oil")
                  end,
                  desc = "open project explorer"
                }
              }
            }
        end
    }
}
