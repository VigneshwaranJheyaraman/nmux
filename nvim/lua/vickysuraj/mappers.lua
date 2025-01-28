vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)
vim.keymap.set("n", "<leader>Q", function()
  vim.cmd("qa!")
end)
vim.keymap.set("n", "<leader>q", function()
  vim.cmd("q!")
end)
vim.keymap.set("n", "\\=", vim.cmd.tabnext)
vim.keymap.set("n", "\\-", vim.cmd.tabprevious)
vim.keymap.set("n", "\\n", vim.cmd.tabnew)


vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Start terminal in on vertical window
vim.keymap.set("n", "<leader>st", function()
    vim.cmd("vert term")
end)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- disable all the arrow keys
vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.keymap.set("", "<left>", "<nop>", { noremap = true })
vim.keymap.set("", "<right>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<left>", "<nop>", { noremap = true })
vim.keymap.set("i", "<right>", "<nop>", { noremap = true })

-- tmux selected copy it
local function tmux_copy()
    vim.cmd("silent !tmux show-buffer | pbcopy")
end
vim.keymap.set("n", "<leader>tcb",tmux_copy)
vim.keymap.set("v", "<leader>tcb",tmux_copy)

-- sql formatter
-- install sql-formatter BLAZINGLY FAST
vim.keymap.set("n", "<leader>fof", function()
    vim.cmd("%!sql-formatter -l postgresql")
end)
vim.keymap.set("v", "<leader>fof", function()
    vim.cmd("'<,'>!sql-formatter -l postgresql")
end)

-- ctrl+c to save and goto NORMAL mode
vim.keymap.set("i", "<C-c>", "<Esc>:w<CR>", { noremap = true})

