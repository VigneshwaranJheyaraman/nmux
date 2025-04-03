local floating_window = require("vickysuraj.floating_window")

local is_REPL_running = false

local function has_file (file_name)
  if vim.fn.executable("rg") then
    local file_found = string.gsub(vim.fn.system("rg --files --color never *" .. file_name .. "*"), "%s+", "")
    return file_found == file_name
  end
  return false
end

local function get_repl_command ()
  if has_file("deps.edn") then
    return "clj -M:dev:dev/deps:repl/conjure"
  elseif has_file("project.clj") then
    return "lein repl"
  else
    return nil
  end
end

local function start_repl ()
  floating_window.toggle_terminal {
    cmd = get_repl_command(),
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
