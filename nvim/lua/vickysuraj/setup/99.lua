local shortcut_utils = require("vickysuraj.shortcuts.utils")

--- I am the opts that can be passed to setup
--- @class SetupOpts99
--- @field path string
--- @field prompts_location table<string>

local M = {}

local function setup_key_mapping(lib_99)
  shortcut_utils.shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        mode = "v",
        shortcut = "<leader>99",
        mapper_cmd_OR_function = lib_99.visual_analyze,
        desc = "I try to understand 99 problems"
      },
      {
        mode = "v",
        shortcut = "<leader>99r",
        mapper_cmd_OR_function = lib_99.visual,
        desc = "I got 99 problems"
      },
      {
        mode = "n",
        shortcut = "<leader>9x",
        mapper_cmd_OR_function = lib_99.stop_all_requests,
        desc = "99 problems! get that hell outta here"
      },
      {
        mode = "n",
        shortcut = "<leader>99s",
        mapper_cmd_OR_function = lib_99.search,
        desc = "I don't want peace I want problems"
      }
    }
  }
end

--- I handle the setup logic
--- @param opts SetupOpts99
M.setup = function(opts)
  local _99 = require("99")
  M.cwd = vim.uv.cwd()
  M.project_directory = vim.fs.basename(M.cwd)
  M.path_99 = opts.path .. "/" .. M.project_directory

  _99.setup {
    provider = _99.Providers.OpenCodeProvider,
    model = "github-copilot/claude-haiku-4.5",
    logger = {
      level = _99.DEBUG,
      path = M.path_99 .. ".99.debug",
      print_on_error = true,
    },
    tmp_dir = "/tmp",
    completion = {
      custom_rules = nil,

      --- Configure @file completion (all fields optional, sensible defaults)
      files = {
        enabled = true,
        max_file_size = 102400, -- bytes, skip files larger than this
        max_files = 10,         -- cap on total discovered files
        exclude = { ".env", ".env.*", "node_modules", ".git", },
      },

      source = "blink",
    },
    md_files = opts.prompts_location
  }

  setup_key_mapping(_99)
end

return M
