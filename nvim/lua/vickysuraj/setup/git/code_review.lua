local M = {}

--- @class CodeReviewOpts
--- @field model string

local function setup_key_maps()
  local shortcut_utils = require("vickysuraj.shortcuts.utils")
  shortcut_utils.shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        shortcut = "<leader>revu",
        mapper_cmd_OR_function = ":CodeReview<CR>",
        desc = "start reviewing panel",
        mode = "n"
      },
      {
        shortcut = "<leader>npr",
        mapper_cmd_OR_function = ":CodeReviewOpen<CR>",
        desc = "Create a PR",
        mode = "n"
      }
    }
  }
end

--- @param opts CodeReviewOpts
M.setup = function(opts)
  local code_review_lib = require("codereview")
  local config = require("config")
  local local_model = config.get_config("local_model")
  local ai_provider = "custom_url"
  local professor_core = require("vickysuraj.professor.core")
  local call_professor = {
    url = professor_core.make_default_ask_url(),
    base_payload = { model = professor_core.default_model },
    on_success = professor_core.get_professor_response,
    headers = {
      [professor_core.secret_key] = professor_core.secret
    },
    prompt_key = "query"
  }
  local opencode_cmd = { cmd = "opencode", args = { "run", "--model", opts.model, "--agent", "build" } }

  code_review_lib.setup({
    -- Provider settings (all auto-detected from git remote)
    base_url     = "https://api.github.com", -- API base URL override (e.g. "https://gitlab.example.com")
    project      = nil,                      -- "owner/repo" auto populated from git remote origin by the lib
    platform     = "github",                 -- "github" | "gitlab" | nil (auto-detect)
    github_token = vim.env.GITHUB_TOKEN,     -- GitHub personal access token

    -- Picker: "telescope", "fzf", or "snacks" (auto-detected)
    picker       = "telescope",

    -- Debug logging to .codereview.log
    debug        = true,

    -- Open review in a new tab (set false to use current window)
    open_in_tab  = true,

    -- Diff viewer
    diff         = {
      context          = 8, -- lines of context (0-20)
      scroll_threshold = 50, -- use scroll mode when file count <= threshold
      comment_width    = 80, -- comment float width
      separator_char   = "╳", -- hunk separator character
      separator_lines  = 3, -- lines in hunk separator
    },

    -- Pipeline
    pipeline     = {
      poll_interval = 10000, -- status poll interval (ms)
      log_max_lines = 5000,  -- max lines in job log viewer
    },

    -- AI review
    ai           = {
      enabled       = true,
      provider      = ai_provider, -- "claude_cli" | "anthropic" | "openai" | "ollama" | "custom_cmd"
      review_level  = "info",      -- "info" | "suggestion" | "warning" | "error"
      max_file_size = 500,         -- skip files larger than N lines (0 = unlimited)

      ollama        = { model = local_model, base_url = "http://localhost:11434", },
      custom_cmd    = opencode_cmd,
      custom_url    = call_professor
    },

    -- Override or disable keybindings
    keymaps      = {
      quit = "q", -- remap quit to q
      -- toggle_resolve = false,  -- disable toggle resolve
    },
  })

  setup_key_maps()
end

return M
