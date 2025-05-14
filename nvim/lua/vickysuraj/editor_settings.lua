local config = require("config")

vim.opt.guicursor = ""

-- whitespace >>>>> tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = false

vim.opt.swapfile = config.get_config("have_swap_file")
vim.opt.backup = false

-- undoing state management
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- increment and highlight search
vim.opt.hlsearch = false
vim.opt.incsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.shell = config.get_config("shell")

if config.get_config("mouse") then
  vim.opt.mouse="a"
else
  vim.opt.mouse=""
end

--set crosshair
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
