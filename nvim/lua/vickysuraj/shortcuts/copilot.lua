local shortcuts = {
  {
    mode = "n",
    shortcut = "<leader>chat",
    mapper_cmd_OR_function = "<cmd>CopilotChat<CR>",
    desc ="Open the copilot chat"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>fix",
    mapper_cmd_OR_function = "<cmd>CopilotChatFix<CR>",
    desc ="Make copilot read your buffer and fix the possible issues"
  },
  {
    mode = "n",
    shortcut = "<leader>prom",
    mapper_cmd_OR_function = "<cmd>CopilotChatPrompts<CR>",
    desc ="Make copilot read your buffer and fix the possible issues"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>rvu",
    mapper_cmd_OR_function = "<cmd>CopilotChatReview<CR>",
    desc = "Make copilot read your buffer and review them and share the explanation"
  }
}

return shortcuts
