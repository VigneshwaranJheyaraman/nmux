local config = require("config")
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cond = config.enable_copilot,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
