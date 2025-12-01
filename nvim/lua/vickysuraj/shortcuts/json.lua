local M = {}

M.enabled = false

M.format_json = function(jq_command)
  if vim.fn.executable("jq") then
    jq_command = jq_command or ""
    vim.cmd("'<,'>!jq" .. jq_command)
    if vim.bo.filetype == nil or vim.bo.filetype ~= "json" or vim.bo.filetype == "" then
      vim.bo.filetype ="json"
    end
  end
end

local utils = require("vickysuraj.shortcuts.utils")

M.setup = function()
  local modes = {"n","v"}
  if not M.enabled then
    utils.shortcuts_table_TO_keymaps({
      shortcuts = {
        {
          mode = modes,
          shortcut = "<leader>jq",
          mapper_cmd_OR_function = M.format_json,
          desc = "Format JSON file",
        },
        {
          mode = modes,
          shortcut = "<leader>jqs",
          mapper_cmd_OR_function = function()
            M.format_json(" '. | tostring'")
          end,
          desc = "convert json to stringified version"
        },
        {
          mode = modes,
          shortcut = "<leader>jqf",
          mapper_cmd_OR_function = function()
            M.format_json(" '. | fromjson'")
          end,
          desc = "convert stringified version of json to json"
        }
      },
    });
    M.enabled = true
  end
end

return M
