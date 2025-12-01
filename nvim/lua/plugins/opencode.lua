return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    local opencode_setup = require("vickysuraj.setup.opencode");
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      prompts = opencode_setup.prompts,
      contexts = opencode_setup.contexts,
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
    -- setup keybinding
    opencode_setup.init()
  end,
}
