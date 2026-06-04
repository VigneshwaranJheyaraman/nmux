local M = {}

M.setup = function()
  local dap = require("dap")
  require("vickysuraj.setup.dap.clojure").setup(dap)
end

return M
