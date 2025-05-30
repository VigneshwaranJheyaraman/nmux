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
    mode = { "n", "v" },
    shortcut = "<leader>prom",
    mapper_cmd_OR_function = "<cmd>CopilotChatPrompts<CR>",
    desc ="Make copilot read your buffer and fix the possible issues"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>rvu",
    mapper_cmd_OR_function = "<cmd>CopilotChatReview<CR>",
    desc = "Make copilot read your buffer and review them and share the explanation"
  },
  {
    mode = { "n" },
    shortcut = "<leader>commit",
    mapper_cmd_OR_function = "<cmd>CopilotChatCommit<CR>",
    desc = "Make copilot review your changes and build up the commit message with more detailing"
  },
  {
    mode = { "n" },
    shortcut = "<leader>spd",
    mapper_cmd_OR_function = function ()
      local branch_name = vim.fn.input("Enter the branch name > ")
      if branch_name == nil or branch_name == "" then
        error("Branch name cannot be empty")
      else
        local review_context = "#revu:" .. branch_name
        vim.cmd("CopilotChatNakeeran " .. review_context)
      end
    end,
    desc = "Call Nakeeran who helps you analyze the PR changes my checking out the files locally and perform an analysis on the same"
  }
}

return shortcuts
