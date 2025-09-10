local shortcuts_utils = require("vickysuraj.shortcuts.utils")
local config = require("config")

local buffer_shortcuts = {
  {
    mode = "n",
    shortcut ="<leader>Q",
    mapper_cmd_OR_function = ":qa!<CR>",
    desc = "force quit all the files"
  },
  {
    mode="n",
    shortcut= "<leader>q",
    mapper_cmd_OR_function= ":q!<CR>",
    desc = "force quit the file"
  },
  {
    mode="v",
    shortcut= "J",
    mapper_cmd_OR_function= ":m '>+1<CR>gv=gv",
    desc = "move selected lines up and down"
  },
  {
    mode="v",
    shortcut= "K",
    mapper_cmd_OR_function= ":m '<-2<CR>gv=gv",
    desc = "move selected lines up and down"
  },
  {
    mode="n",
    shortcut= "J",
    mapper_cmd_OR_function= "mzJ`z",
    desc = "join lines and keep cursor in the same place"
  },
  {
    mode="x",
    shortcut= "<leader>p",
    mapper_cmd_OR_function= [["_dP]],
    desc = "paste without overwriting the clipboard"
  },
  {
    mode="n",
    shortcut= "<leader>s",
    mapper_cmd_OR_function= [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    desc = "replace word under cursor"
  },
  {
    mode="n",
    shortcut= "<leader>x",
    mapper_cmd_OR_function= "<cmd>!chmod +x %<CR>",
    opts = { silent = true },
    desc = "make the file executable"
  },
  {
    mode="n",
    shortcut= "<leader>f",
    mapper_cmd_OR_function= function()
      if vim.lsp ~= nil then
        vim.lsp.buffer.format()
      end
    end,
    desc = "format the buffer"
  },
  {
    mode="n",
    shortcut= "<leader>gb",
    mapper_cmd_OR_function= ":b#<CR>",
    desc = "jump between buffers"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>y",
    mapper_cmd_OR_function = [["+y]],
    desc = "yank to clipboard"
  },
  {
    mode = "i",
    shortcut = "<C-c>",
    mapper_cmd_OR_function = "<Esc>:w<CR>",
    desc = "save the file and go to normal mode",
    opts = { noremap = true }
  }
}

local disable_arrow_key_mappings = {
  {
    mode="",
    shortcut= "<up>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="",
    shortcut= "<down>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="",
    shortcut= "<left>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="",
    shortcut= "<right>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="i",
    shortcut= "<up>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="i",
    shortcut= "<down>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="i",
    shortcut= "<left>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="i",
    shortcut= "<right>",
    mapper_cmd_OR_function= "<nop>",
    opts = { noremap = true },
    desc = "disable arrow keys in insert mode"
  },
  {
    mode="n",
    shortcut= "<leader>bd",
    mapper_cmd_OR_function= "<Esc>:bdelete %<CR>",
    desc = "delete the current buffer"
  }
};

if not config.get_config("arrow_keys") then
  -- disable all the arrow keys
  if not config.get_config("arrow_keys") then
    shortcuts_utils.shortcuts_table_TO_keymaps{ shortcuts = disable_arrow_key_mappings }
  end
end

shortcuts_utils.shortcuts_table_TO_keymaps{ shortcuts = buffer_shortcuts }
