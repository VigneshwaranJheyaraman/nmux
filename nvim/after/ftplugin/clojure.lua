local floating_window = require("vickysuraj.floating_window")

local function has_file (file_name)
  if vim.fn.executable("rg") then
    local files_found = vim.cmd("silent!rg --files --color never *" .. file_name .. "*", {silent = true})
    if files_found ~= "" then
      return false
    end
  end
  return true
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

vim.keymap.set("n", "<leader>cch", [[ _d$i;; =====<Esc>pa=====<Esc> ]])
vim.keymap.set("n", "<localleader>repl", function ()
  floating_window.toggle_terminal {
    cmd = get_repl_command(),
    on_term_enter = floating_window.toggle_terminal
  }
end)
