local M = {}
local genModule = require("gen")

local shortCuts = {
  {
    mapper_cmd_OR_function = ":Gen Chat<CR>",
    shortcut = "<leader>lama",
    desc = "Start conversation with local model",
    mode = { "n", "v" }
  },
  {
    mapper_cmd_OR_function = ":Gen GenCommit<CR>",
    shortcut = "<leader>rama",
    desc = "Understand the code and generate the commit message",
    mode = "n"
  },
  {
    mode = "n",
    desc = "load gen.nvim local ollama plugin",
    mapper_cmd_OR_function = ":echo \"loading local-ollama plugin\"<CR>",
    shortcut = "<leader>lai"
  }
}

local function setup_keybindings()
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = shortCuts,
  }
end

local function setup_prompts()
  genModule.prompts["GenCommit"] = {
    replace = false,
    prompt = function()
      if vim.fn.executable("git") then
        local git_diff = vim.fn.execute("!git diff --staged")
        local git_status = vim.fn.execute("!git status")
        local previous_commits = vim.fn.execute("!git log --oneline -n 10")

        return (
          "Given below the current status of the repository.\n"
          .. git_status .. "\n"
          .. "And below mentioned set of changes made on the files"
          .. git_diff .. "\n"
          .. "With previous history of changes made on the repository as mentioned below" .. "\n"
          .. previous_commits .. "\n"
          .. [[ Write commit message for the change with commitizen convention.
          ## GUIDELINES
          - Keep the title under 50 characters and wrap message at 13000 characters.
          - Given the staged changes analyze it and generate a detailed commit message
          - The commitize convention MUST have
            - <title>
            - <body>
            - <changelog>
            - BREAKING_CHANGES if and only if any
          - Format as markdown.
          - Explain in more detail about what was changed and why in the commit message
          - Include the changelog entries for the changes and have them wrapped within gitcommit code block

          Make sure you follow the GUIDELINES]]
        )
      else
        return "No git enabled so cannot understand the code changes"
      end
    end
  }
end

--- @class OllamaOpts
--- @field model string|nil

--- I setup the plugin
--- @param plugin_opts OllamaOpts
M.setup = function(plugin_opts)
  assert(plugin_opts.model ~= nil, "make sure default model is provided")
  genModule.setup {
    model = plugin_opts.model,
    display_mode = "vertical-split",
    show_prompt = true,
    show_model = true,
    init = function()
      vim.fn.execute("!ollama serve > /dev/null 2>&1 &", 'silent')
    end,
    debug = false
  }

  setup_prompts()

  setup_keybindings()
end

return M
