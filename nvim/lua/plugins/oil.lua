return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = { show_hidden = true },
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
    },
    main = "vickysuraj.setup.oil"
  },
  { "nvim-tree/nvim-web-devicons", lazy = true }, -- use if prefer nvim-web-devicons
}
