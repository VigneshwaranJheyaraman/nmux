return {
  {
    "Olical/conjure",
    ft = { "clojure", "python" }, -- etc
    lazy = true,
    init = function()
      -- vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = require("vickysuraj.utils.clojure").get_repl_command()
      vim.g["conjure#mapping#doc_word"] = false
    end
  }
}
