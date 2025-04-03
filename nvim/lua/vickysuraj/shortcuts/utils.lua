local M = {}

M.shortcuts_table_TO_keymaps = function (shortcuts_table)
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
    vim.keymap.set(mode, shoortcut, mapper_cmd_OR_function, opts)
  end
end

return M
