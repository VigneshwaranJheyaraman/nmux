local mdown = require("render-markdown")

mdown.enable()

vim.keymap.set("n", "<leader>md", function()
  mdown.buf_toggle()
end)
