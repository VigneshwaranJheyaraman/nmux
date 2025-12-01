return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
    local shortcut_utils = require("vickysuraj.shortcuts.utils");
    local opencode = require("opencode");
    shortcut_utils.shortcuts_table_TO_keymaps {
      removeKeymap = true,
      shortcuts = {
        {
          mode = { "n", "x" },
          shortcut = "<leader>ask",
          mapper_cmd_OR_function = function() opencode.ask("@this: ", { submit = true }) end,
          desc = "Ask opencode"
        },
        {
          mode = { "n", "x" },
          shortcut = "<C-x>",
          mapper_cmd_OR_function = function() opencode.select() end,
          desc = "execute opencode action..."
        },
        {
          mode = { "n", "t" },
          shortcut = "<leader>ai",
          mapper_cmd_OR_function = function() opencode.toggle() end,
          desc = "Toggle opencode"
        },
        {
          mode = { "n", "x" },
          shortcut = "<leader>bask",
          mapper_cmd_OR_function = function() opencode.prompt("@this") end,
          desc = "add buffer to opencode"
        },
        {
          mode = "n",
          shortcut = "<C-w>kai",
          mapper_cmd_OR_function = function() opencode.command("session.half.page.up") end,
          desc = "opencode session half page up"
        },
        {
          mode = "n",
          shortcut = "<C-w>jai",
          mapper_cmd_OR_function = function() opencode.command("session.half.page.down") end,
          desc = "opencode session half page down"
        }
      }
    }
  end,
}
