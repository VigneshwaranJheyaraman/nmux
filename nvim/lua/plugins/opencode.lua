return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
    },
    keys = { "<leader>ai" },
    main = "vickysuraj.setup.opencode",
    config = true,
    -- requires opencode v1.0.223 not v1.1.* because
    -- opencode latest is not booting up server by default
    -- which will cause the plugin to fail to establish a
    -- connection
    cond = vim.fn.executable("opencode") == 1
  },
  -- Recommended for `ask()` and `select()`.
  -- Required for `snacks` provider.
  ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
  {
    "folke/snacks.nvim",
    opts = { input = {}, picker = {}, terminal = {} },
    keys = { "<leader>ai" }
  },
}
