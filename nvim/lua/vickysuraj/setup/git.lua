local function checkout_master (opts)
    opts = opts or {}
    local branch_name = opts.branch_name
    if branch_name == nil or branch_name == ""
        then
            branch_name = "master"
    end
    vim.cmd("silent! Git checkout " .. branch_name)
end

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
      mapper_cmd_OR_function = function ()
        checkout_master()
        vim.cmd.Git("pull origin master")
      end,
      desc = "pull origin master"
    },
    {
      mode = "n",
      shortcut = "<leader>gch",
      mapper_cmd_OR_function = function()
        local branch_name = vim.fn.input{
          prompt = "branch name:"
        }
        if branch_name ~= nil or branch_name ~= "" then
          checkout_master {
            branch_name = branch_name
          }
        end
      end,
      desc = "checkout branch"
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
      mapper_cmd_OR_function = function ()
        vim.cmd.Git("stash -m " .. os.date("%d-%m-%Y@%H:%M:%S"))
      end
    },
    {
      mode = "n",
      shortcut = "<leader>bout",
      desc = "apply the stashed changes",
      mapper_cmd_OR_function = function ()
        vim.cmd.Git("stash pop")
      end
    }}
  }
