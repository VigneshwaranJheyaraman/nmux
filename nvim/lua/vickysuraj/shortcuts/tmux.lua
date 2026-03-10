local prompt_util = require("vickysuraj.utils.input")
local picker_utils = require("vickysuraj.utils.picker")

local function get_all_sessions()
  return vim.split(vim.fn.system("tmux list-sessions -F '#{session_name}'"), "\n", { trimempty = true })
end

--- @param on_input function
local function session_modifier(on_input)
  prompt_util.ask {
    prompt = "Session Name:",
    on_confirm = function(session_name)
      if session_name ~= nil and #session_name > 0 then
        on_input(session_name)
      else
        print("No session inputed")
      end
    end
  }
end

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      mode = "n",
      shortcut = "<C-f>",
      mapper_cmd_OR_function = "<cmd>silent !tmux neww tmux-sessionizer<CR>",
      desc = "refresh tmux session"
    },
    {
      mode = { "n", "v" },
      shortcut = "<leader>tcb",
      mapper_cmd_OR_function = function()
        vim.cmd("silent !tmux show-buffer | pbcopy")
      end,
      desc = "copy tmux buffer to clipboard"
    },
    {
      mode = "n",
      shortcut = "<leader>tnew",
      mapper_cmd_OR_function = function()
        session_modifier(function(session_name)
          -- open as a daemon
          vim.cmd("silent !tmux new-session -c $VJ_HOME -s " .. session_name .. " -d")
        end)
      end,
      desc = "creates a new session"
    },
    {
      mode = "n",
      shortcut = "<leader>sess",
      mapper_cmd_OR_function = function()
        picker_utils.open_picker {
          on_select = function(session_name)
            vim.cmd("!tmux switch -t " .. session_name)
          end,
          options = get_all_sessions,
          title = "Select available sessions"
        }
      end,
      desc = "swaps between session"
    },
    {
      mode = "n",
      shortcut = "<leader>tkill",
      mapper_cmd_OR_function = function()
        picker_utils.open_picker {
          on_select = function(session_name)
            vim.cmd("silent! tmux kill-session -t " .. session_name)
          end,
          options = get_all_sessions,
          title = "Kill session"
        }
      end,
      desc = "swaps between session"
    }
  }
}
