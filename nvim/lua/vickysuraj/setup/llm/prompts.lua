local picker_utils = require("vickysuraj.utils.picker")
local prompt_utils = require("vickysuraj.utils.input")
local shortcut_utils = require("lua.vickysuraj.shortcuts.utils")
local M = {}
local is_enabled = true
--- @type table<string, string>
local available_prompts = {}

local function get_all_prompts()
  local prompt_names = {}
  for name, _ in ipairs(available_prompts) do
    table.insert(prompt_names, name)
  end
  return prompt_names
end

local default_opts = {
  dir = "/tmp/prompts",
  prompt_ext = "*.md"
}

--- @param dir string
--- @param extension_glob string
local function find_prompts(dir, extension_glob)
  if vim.fn.isdirectory(dir) then
    for file_name in vim.split(vim.fn.glob(dir .. "/" .. extension_glob), "\n", { trimempty = true }) do
      local file_handler = io.open(dir .. "/" .. file_name, "rb")
      assert(file_handler ~= nil, "Cannot open file " .. file_name)
      available_prompts[file_name] = file_handler:read("*all")
    end
  else
    is_enabled = false
    print("No directory " .. dir .. "exists")
  end
end

local function setupKeyMaps()
  shortcut_utils.shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        shortcut = "<leader>prompts",
        mapper_cmd_OR_function = function()
          picker_utils.open_picker {
            title = "Select the markdown",
            on_select = M.build_prompt,
            options = get_all_prompts()
          }
        end,
        desc = "list all the prompts and select one of the them",
        mode = "n"
      }
    },
    options = {
      removeKeymap = true
    }
  }
end

local function copy_prompt_to_clipboard(prompt, prompt_vars)
  local prompt_vars_list = vim.split(prompt_vars, ",", { trimempty = true })
  for i, prompt_var in ipairs(prompt_vars_list) do
    prompt = string.gsub(prompt, "$" .. i, prompt_var)
  end
  vim.cmd("!silent pbcopy " .. prompt)
end

--- @class PromptOpts
--- @field dir string the location where the prompts exists
--- @field prompt_ext string? the extension of the prompt files in glob pattern

--- @type PromptOpts
M.opts = default_opts

--- @param prompt_name string
M.build_prompt = function(prompt_name)
  local prompt_content = available_prompts[prompt_name]
  assert(prompt_content ~= nil, "No prompt found")
  prompt_utils.ask {
    prompt = "Enter the args as Comma seperated values:",
    on_confirm = function(user_input)
      copy_prompt_to_clipboard(prompt_content, user_input)
    end
  }
end

--- @param opts PromptOpts
M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts)
  assert(M.opts.prompt_ext ~= nil, "Missing glob pattern for prompts")
  find_prompts(M.opts.dir, M.opts.prompt_ext)
  if is_enabled then
    setupKeyMaps()
  end
end
