local floating_window = require("vickysuraj.floating_window")
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", floating_window.toggle_terminal, {})

-- setup keymap
vim.keymap.set({ "n", "v", "t" }, "<leader>term", function ()
  floating_window.toggle_terminal()
end)

