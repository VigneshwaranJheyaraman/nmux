local telescope_builtin_functions = require("telescope.builtin")
local shortcuts = {
  {
    mode = 'n',
    shortcut = '<leader>ff',
    mapper_cmd_OR_function = telescope_builtin_functions.find_files,
    opts = {},
    desc = "find files"
  },
  {
    mode = "n",
    shortcut = "<leader>fgf",
    mapper_cmd_OR_function = telescope_builtin_functions.git_files,
    opts = {},
    desc = "find files in git repository"
  },
  {
    mode ='n',
    shortcut = '<leader>gf',
    mapper_cmd_OR_function = function()
      telescope_builtin_functions.grep_string({search = vim.fn.input("Grep > ")})
    end,
    opts = {},
    desc = "grep string in the entire project"
  },
  {
    mode = 'n',
    shortcut = '<leader>fb',
    mapper_cmd_OR_function = telescope_builtin_functions.buffers,
    opts = {},
    desc = "find all buffers"
  },
  {
    mode = 'n',
    shortcut = '<leader>ft',
    mapper_cmd_OR_function = telescope_builtin_functions.help_tags,
    opts = {},
    desc = "help tags"
  },
  {
    mode = 'n',
    shortcut = '<leader>fh',
    mapper_cmd_OR_function = function ()
      telescope_builtin_functions.keymaps {
        show_plug = false,
      }
    end,
    opts = {},
    desc = "help shortcuts"
  },
  -- edit neovim's configuration
  {
    mode = "n",
    shortcut = "<leader><leader>nvim",
    mapper_cmd_OR_function = function ()
      telescope_builtin_functions.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end,
    desc = "edit neovim's configuration"
  },
  {
    mode = "n",
    shortcut = "<leader><leader>lazy",
    mapper_cmd_OR_function = function ()
      telescope_builtin_functions.find_files {
        cwd = vim.fn.stdpath("data") .. "/lazy"
      }
    end,
    desc = "check all lazy plugins source code"
  },
  {
    mode = "n",
    shortcut = "<leader>theme",
    mapper_cmd_OR_function = function ()
      telescope_builtin_functions.colorscheme {
        enable_preview = true,
      }
    end,
    desc = "choose color theme"
  }
}


return shortcuts
