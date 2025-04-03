local lsp_shortcuts = {
  {
    mode="n",
    shortcut= "<localleader>n",
    mapper_cmd_OR_function= vim.cmd.tabnew,
    desc= "open a new tab"
  },

  {
    mode="n", 
    shortcut = "<C-d>",
    mapper_cmd_OR_function = "<C-d>zz",
    desc = "center the cursor after scrolling down"
  },
  {
    mode="n",
    shortcut = "<C-u>",
    mapper_cmd_OR_function = "<C-u>zz",
    desc = "center the cursor after scrolling up"
  },
  {
    mode = { "n", "v" },
    shortcut = "<leader>d",
    mapper_cmd_OR_function = [["_d]],
    desc = "delete to void register"
  },

  {
    mode= "n",
    shortcut = "<C-k>",
    mapper_cmd_OR_function ="<cmd>cnext<CR>zz",
    desc = "go to next location in diagnostics list"
  },
  {
    mode= "n",
    shortcut = "<C-j>",
    mapper_cmd_OR_function = "<cmd>cprev<CR>zz",
    desc = "go to previous location in diagnostics list"
  },
  {
    mode="n",
    shortcut= "<leader>k",
    mapper_cmd_OR_function= "<cmd>lnext<CR>zz",
    desc = "go to next location in quickfix list"
  },
  {
    mode="n",
    shortcut= "<leader>j",
    mapper_cmd_OR_function= "<cmd>lprev<CR>zz",
    desc = "go to previous location in quickfix list"
  },
  {
    -- install sql-formatter BLAZINGLY FAST
    mode = { "n", "v" },
    shortcut = "<leader>fof",
    mapper_cmd_OR_function = function()
      vim.cmd("%!sql-formatter -l postgresql")
    end,
    desc = "format sql file"
  }
}

require("vickysuraj.shortcuts.utils").shortcuts_table_TO_keymaps(lsp_shortcuts)
