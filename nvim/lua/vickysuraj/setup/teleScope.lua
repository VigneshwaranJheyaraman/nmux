local telescope_mappings = {}
local shortcut_utils = require("vickysuraj.shortcuts.utils")

local function setup_todo_comments()
  -- todo comments
  require("todo-comments").setup();
  shortcut_utils.shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        shortcut = "<leader>todo",
        mapper_cmd_OR_function = ":TodoLocList <CR>",
        mode = { "n" },
        desc = "See all the TODO across the project"
      }
    }
  }
end

telescope_mappings.setup = function(opts)
  require("telescope").setup {
    pickers = {
      find_files = {
        theme = "ivy"
      }
    },
    extensions = {
      fzf = {}
    }
  }
  shortcut_utils.shortcuts_table_TO_keymaps {
    shortcuts = require("vickysuraj.shortcuts.project_explorer")
  }
  -- load multigrep
  require("vickysuraj.setup.multigrep").setup();

  setup_todo_comments()
end

return telescope_mappings
