return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
    },
    keys = { "<leader>ai" },
    main = "vickysuraj.setup.opencode",
    config = true
  },
  -- Recommended for `ask()` and `select()`.
  -- Required for `snacks` provider.
  ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
  {
    "folke/snacks.nvim",
    opts = { input = {}, picker = {}, terminal = {} },
    lazy = true
  },
}
