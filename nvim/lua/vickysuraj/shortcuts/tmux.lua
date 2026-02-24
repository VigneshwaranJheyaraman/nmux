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
        local session_name = vim.fn.input("Session Name:")
        -- open as a daemon
        vim.cmd("silent !tmux new-session -c $VJ_HOME -s " .. session_name .. " -d")
      end,
      desc = "creates a new session"
    },
    {
      mode = "n",
      shortcut = "<leader>sess",
      mapper_cmd_OR_function = function()
        local session_name = vim.fn.input("Session Name:")
        vim.cmd("!tmux switch -t " .. session_name)
      end,
      desc = "swaps between session"
    },
    {
      mode = "n",
      shortcut = "<leader>tkill",
      mapper_cmd_OR_function = function()
        local session_name = vim.fn.input("Session Name:")
        vim.cmd("silent! tmux kill-session -t " .. session_name)
      end,
      desc = "swaps between session"
    }
  }
}
