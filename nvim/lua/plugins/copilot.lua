return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = true,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      model = "gpt-4o"
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
