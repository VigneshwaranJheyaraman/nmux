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

return M
