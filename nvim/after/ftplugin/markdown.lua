local function external_preview()
  local mdown = require("preview")

  mdown.setup(require("vickysuraj.setup.markdown").get_setup_opts())

  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        mode = "n",
        shortcut = "<leader>pmd",
        mapper_cmd_OR_function = function()
          mdown.toggle()
        end
      },
      {
        mode = "n",
        shortcut = "<leader>pvu",
        mapper_cmd_OR_function = function()
          if vim.fn.executable("open") then
            vim.cmd("!open -a \"Firefox\" %")
          end
        end
      }
    }
  }
end

external_preview()
