return {
  {
    "Olical/conjure",
    ft = { "clojure", "python" }, -- etc
    lazy = true,
    init = function()
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
    end
  }
}
