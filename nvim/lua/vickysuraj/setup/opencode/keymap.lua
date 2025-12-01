local M = {}

M.setup_keymap = function()
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
        shortcut = "<leader>tool",
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
        mode = {"n", "v"},
        shortcut = "<C-w>kai",
        mapper_cmd_OR_function = function() opencode.command("session.page.up") end,
        desc = "opencode session page up"
      },
      {
        mode = {"n", "v"},
        shortcut = "<C-w>jai",
        mapper_cmd_OR_function = function() opencode.command("session.page.down") end,
        desc = "opencode session page down"
      },
      {
        mode = "n",
        shortcut = "<leader>aidel",
        mapper_cmd_OR_function = function() opencode.command("session.clear") end,
        desc = "opencode input session cleared"
      }
    }
  }
end

return M
