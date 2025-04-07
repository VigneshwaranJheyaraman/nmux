local floating_window = require("vickysuraj.floating_window")
local clojure_utils = require("vickysuraj.utils.clojure")

local function start_repl ()
  floating_window.toggle_terminal {
    cmd = clojure_utils.get_repl_command(),
    on_term_enter = floating_window.toggle_terminal
  }
end

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  {
    mode = "n",
    shortcut = "<leader>cch",
    mapper_cmd_OR_function = [[ _d$i;; =====<Esc>pa=====<Esc> ]],
    desc = "clojure comment header"
  },
  {
    mode = "n",
    shortcut = "<localleader>repl",
    mapper_cmd_OR_function = start_repl,
    desc = "clojure start repl"
  }
}
