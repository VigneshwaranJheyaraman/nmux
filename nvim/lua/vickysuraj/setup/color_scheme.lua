local M = {}

---@type string[]
local schemes_available = vim.api.nvim_get_runtime_file("colors/*", true)
local color_schemes = {}

for _, fullpath in pairs(schemes_available) do
  table.insert(color_schemes, vim.fn.fnamemodify(fullpath, ":t:r"))
end

M.ColorMyBash = function(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

M.randomColorSchema = function()
  M.ColorMyBash(color_schemes[math.random(#color_schemes)])
end

M.setup = function(_)
  require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
    shortcuts = {
      {
        mode = "n",
        shortcut = "<leader>cs",
        mapper_cmd_OR_function = function()
          M.randomColorSchema()
        end,
        desc = "random color schema"
      },
      {
        mode = "n",
        shortcut = "<leader>pine",
        mapper_cmd_OR_function = function()
          M.ColorMyBash("rose-pine")
        end,
        desc = "rose-pine color schema"
      }
    }
  }
  M.ColorMyBash(require("config").get_config("default_theme"))
end

return M
