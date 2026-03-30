local prompt_utils = require("vickysuraj.utils.input")
local picker_utils = require("vickysuraj.utils.picker")

--- @class CheckoutOpts
--- @field branch_name string?
--- @field new_branch boolean?

--- @class BranchInfo
--- @field name string
--- @field time string

--- @param opts CheckoutOpts
local function checkout_master(opts)
  opts = opts or {}
  local is_new_branch = opts.new_branch == true
  local branch_name = opts.branch_name
  if branch_name == nil or branch_name == ""
  then
    branch_name = "master"
  end
  if is_new_branch then
    branch_name = "-b " .. branch_name
  end
  vim.cmd("silent! Git checkout " .. branch_name)
end

--- @return PickerList[]
local function list_all_branch()
  local all_branches = vim.split(
    vim.fn.system(
      "git branch --list --sort=-committerdate --format='{\"name\": \"%(refname:short)\", \"time\": \"%(committerdate:relative)\"}'"),
    "\n", { trimempty = true })
  --- @type PickerList[]
  local branches_info = {}
  for _, info in ipairs(all_branches) do
    --- @type BranchInfo
    local git_branch_info = vim.fn.json_decode(info)
    table.insert(branches_info, {
      label = git_branch_info.name .. " committed " .. git_branch_info.time,
      id = git_branch_info.name
    })
  end
  return branches_info
end

local M = {}

M.setup = function(_)
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        mode = "n",
        shortcut = "<leader>gs",
        mapper_cmd_OR_function = vim.cmd.Git,
        desc = "git status"
      },
      {
        mode = "n",
        shortcut = "<leader>gwho",
        mapper_cmd_OR_function = function()
          vim.cmd.Git("blame")
        end,
        desc = "git blame"
      },
      {
        mode = "n",
        shortcut = "<leader>gcm",
        mapper_cmd_OR_function = checkout_master,
        desc = "checkout master"
      },
      {
        mode = "n",
        shortcut = "<leader>gpom",
        mapper_cmd_OR_function = function()
          checkout_master {
          }
          vim.cmd.Git("pull origin master")
        end,
        desc = "pull origin master"
      },
      {
        mode = "n",
        shortcut = "<leader>gcb",
        desc = "checkout branch",
        mapper_cmd_OR_function = function()
          picker_utils.open_picker {
            options = list_all_branch,
            title = "Select branch",
            on_select = function(branch_name)
              checkout_master {
                branch_name = branch_name
              }
            end
          }
        end
      },
      {
        mode = "n",
        shortcut = "<leader>gch",
        mapper_cmd_OR_function = function()
          prompt_utils.ask {
            prompt = "branch name:",
            on_confirm = function(branch_name)
              if branch_name ~= nil or branch_name ~= "" then
                checkout_master {}
                checkout_master {
                  branch_name = branch_name,
                  new_branch = true
                }
              end
            end
          }
        end,
        desc = "checkout new branch"
      },
      {
        mode = "n",
        shortcut = "<leader>gprom",
        mapper_cmd_OR_function = function()
          vim.cmd.Git("pull --rebase origin master")
        end,
        desc = "rebase origin master"
      },
      {
        mode = "n",
        shortcut = "<leader>bin",
        desc = "stash the changes",
        mapper_cmd_OR_function = function()
          vim.cmd.Git("stash -m " .. os.date("%d-%m-%Y@%H:%M:%S"))
        end
      },
      {
        mode = "n",
        shortcut = "<leader>bout",
        desc = "apply the stashed changes",
        mapper_cmd_OR_function = function()
          vim.cmd.Git("stash pop")
        end
      } }
  }
end

return M
