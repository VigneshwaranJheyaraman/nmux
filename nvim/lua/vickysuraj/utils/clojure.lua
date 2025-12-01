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
      value = "\n(do\n\t(require 'dev)\n\t(dev/restart {:without (dev/exclude-states)}))\n",
      override = true
    }
  };

  for _, register in pairs(registry) do
    local existingValue = vim.fn.getreg(register.name)
    local value = register.value
    local reg_name = register.name
    if register.override then
      vim.cmd(string.format("let @%s=\"\"", string.lower(reg_name)))
      existingValue = ""
    end
    if existingValue == "" then
      vim.fn.setreg(reg_name, value);
    end
  end
end

return M
