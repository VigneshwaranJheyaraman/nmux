local file_utils = require("vickysuraj.utils.file")
local M = {}

M.get_repl_command  = function ()
  if file_utils.has_file("deps.edn") then
    return "clj -M:dev:dev/deps:repl/conjure"
  elseif file_utils.has_file("project.clj") then
    return "lein repl"
  else
    return nil
  end
end

M.setup_default_register = function ()
  local registry = {
    {
      name = "S",
      value = "(do\n\t(require 'dev)\n\t(dev/restart {:without (dev/exclude-states)}))"
    }
  };

  for _, register in pairs(registry) do
    local existingValue = vim.fn.getreg(register.name)
    local value = register.value
    if existingValue == "" then
      vim.fn.setreg(register.name, value);
    end
  end
end

return M
