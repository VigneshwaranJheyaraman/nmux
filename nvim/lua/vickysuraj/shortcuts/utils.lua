local M = {}

-- add shortcuts keymaps
-- @param shortcuts_table table
-- @property shortcuts_table.mode string
-- @property shortcuts_table.shortcut string
-- @property shortcuts_table.mapper_cmd_OR_function string | function
-- @property shortcuts_table.opts table
-- @property shortcuts_table.desc string
M.shortcuts_table_TO_keymaps = function (keymaps_with_options)
  local shortcuts_table = keymaps_with_options.shortcuts;
  local options = keymaps_with_options.options or {};
  local removeKeymap = options.removeKeymap or false
  for _, shortcut in pairs(shortcuts_table) do
    local mode = shortcut.mode or "n"
    local shoortcut = shortcut.shortcut
    local mapper_cmd_OR_function = shortcut.mapper_cmd_OR_function
    local opts = shortcut.opts or {}
    local default_desc = shortcut.desc
    if default_desc == nil then
      if type(mapper_cmd_OR_function) == "function" then
        -- get the name of the function
        default_desc = debug.getinfo(mapper_cmd_OR_function).name
      else
        default_desc = ("Sorry enakku theriyathu - " .. math.random(1000))
      end
    end
    local default_opts = {
      desc = default_desc,
    }
    for ki, val_u in pairs(default_opts) do
      opts[ki] = opts[ki] or val_u
    end
    if removeKeymap then
      pcall(function()
        vim.keymap.del(mode, shoortcut)
      end)
    else
      vim.keymap.set(mode, shoortcut, mapper_cmd_OR_function, opts)
    end
  end
end

return M
