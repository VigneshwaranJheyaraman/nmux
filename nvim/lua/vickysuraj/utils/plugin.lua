local lazyModule = nil

-- @module lazy
-- @return table
local function lazy()
  if lazyModule == nil then
    lazyModule = require("lazy")
  end
  return lazyModule
end

local M = {}

-- @type lazy table
-- @type pluginName string
M.find_plugin_info = function(pluginName)
  return (
    vim.tbl_filter(
      function (pluginInfo)
        return (
          string.match(string.lower(pluginInfo.name), pluginName) ~= nil
        )
      end,
      lazy().plugins())
    )
  end

M.load_plugin = function(pluginName, callbackFunction)
  callbackFunction = callbackFunction or function() end
  local pluginsInfo = M.find_plugin_info(pluginName);
  if #pluginsInfo > 0 then
    vim.notify("reloading copilot plugins:" .. #pluginsInfo)
    lazy().load {
      plugins = pluginsInfo
    }
    callbackFunction(pluginsInfo)
  end
end

M.source_file = function(filePath)
  vim.cmd("so " .. vim.fn.stdpath("config") .. filePath)
end

return M
