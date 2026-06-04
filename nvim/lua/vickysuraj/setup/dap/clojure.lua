local M = {}

M.setup = function(dap_lib)
  dap_lib.adapters.clojure = {
    type = 'executable',
    command = 'clojure',
    args = {
      '-Sdeps', '{:deps {uk.me.oli/clojure-dap {:mvn/version "RELEASE"}}}',
      '-X', 'clojure-dap.main/run',
    },
  }

  dap_lib.configurations.clojure = {
    {
      name = 'Attach to nREPL',
      type = 'clojure',
      request = 'attach',
    },
  }
end

return M
