require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      mode = "n",
      shortcut = "<leader>cch",
      mapper_cmd_OR_function = [[ _d$i;; =====<Esc>pa=====<Esc> ]],
      desc = "clojure comment header"
    }
  }
}

local clojure_utils = require("vickysuraj.utils.clojure")

clojure_utils.setup_default_register()

clojure_utils.enable_folding()
