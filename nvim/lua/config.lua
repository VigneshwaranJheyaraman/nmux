local pluginUtils = require("vickysuraj.utils.plugin")
local M = {}

local state = {
  copilot = false,
  arrow_keys = false,
  have_swap_file = false,
  shell = "/bin/zsh",
  mouse = false,
  default_theme = "zaibatsu",
}

local function hasKeyInMap(map, key)
  return vim.tbl_contains(vim.tbl_keys(map), key)
end

-- @param configName string
local function change_config(configName, configValue)
  if hasKeyInMap(state, configName) then
    state[configName] = configValue
  end
end

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps {
  shortcuts = {
    {
      mode = "n",
      shortcut = "<leader>tcp",
      mapper_cmd_OR_function = function()
        local copilot_enabled = (not state.copilot)
        local pluginName = "copilot"
        change_config(pluginName, copilot_enabled)
        if copilot_enabled then
          pluginUtils.load_plugin(pluginName, nil)
        end
        pluginUtils.source_file("/after/plugin/copilot.lua")
      end,
      opts = { noremap = true, silent = true },
      desc = "Toggle copilot",
    }
  }
}

M.get_config = function(configName)
  if hasKeyInMap(state, configName) then
    return state[configName]
  else
    return false
  end
end

return M
