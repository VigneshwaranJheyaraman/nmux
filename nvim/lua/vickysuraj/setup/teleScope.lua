local telescope_mappings = {}

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
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = require("vickysuraj.shortcuts.project_explorer")
  }
  -- load multigrep
  require("vickysuraj.setup.multigrep").setup();
end

return telescope_mappings
