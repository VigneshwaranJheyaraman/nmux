return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cond = require("config").get_config("copilot"),
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      model = "gpt-4o",
      contexts = require("vickysuraj.setup.copilot.context"),
      prompts = require("vickysuraj.setup.copilot.prompts")
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
