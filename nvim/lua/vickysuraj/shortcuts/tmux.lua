require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  {
    mode = "n",
    shortcut = "<C-f>",
    mapper_cmd_OR_function = "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    desc = "refresh tmux session"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>tcb",
    mapper_cmd_OR_function = function ()
      vim.cmd("silent !tmux show-buffer | pbcopy")
    end,
    desc = "copy tmux buffer to clipboard"
  }
}
