local keymapUtils = require("vickysuraj.shortcuts.utils")
local copilotShortcuts = require("vickysuraj.shortcuts.copilot")
local isCopilotEnabled = require("config").get_config("copilot")
if isCopilotEnabled then
  keymapUtils.shortcuts_table_TO_keymaps{
    shortcuts = copilotShortcuts
  }
else
  keymapUtils.shortcuts_table_TO_keymaps{
    shortcuts = copilotShortcuts,
    options = { removeKeymap = true }
  }
end
