local M = {}
local nvim_lsp = vim.lsp.config
local shortcut_utils = require("vickysuraj.shortcuts.utils")

local function attach_lsp_bindings(event)
    local bufnr = event.buf
    local opts = {buffer = bufnr, remap = false}

    local all_shortcuts = {
      {
        mode="n",
        shortcut="<leader>gd",
        mapper_cmd_OR_function=function() vim.lsp.buf.definition() end,
        opts = opts,
        desc = "go to definition"

      },
      {
        mode="n",
        shortcut="K",
        mapper_cmd_OR_function=function() vim.lsp.buf.hover() end,
        opts = opts,
        desc = "hover against the variable under cursor"
      },
      {
        mode="n",
        shortcut="<leader>vws",
        mapper_cmd_OR_function=function() vim.lsp.buf.workspace_symbol() end,
        opts = opts,
        desc = "find workspace symbol"
      },
      {
        mode="n",
        shortcut="<leader>vd",
        mapper_cmd_OR_function=function() vim.diagnostic.open_float() end,
        opts = opts,
        desc = "open floating diagnostic"
      },
      {
        mode = "n",
        shortcut = "[d",
        mapper_cmd_OR_function = function() vim.diagnostic.goto_next() end,
        opts = opts,
        desc = "go to next diagnostic"

      },
      {
        mode = "n",
        shortcut = "]d",
        mapper_cmd_OR_function = function() vim.diagnostic.goto_prev() end,
        opts = opts,
        desc = "go to previous diagnostic"
      },
      {
        mode = "n",
        shortcut = "<leader>sd",
        mapper_cmd_OR_function = function() vim.diagnostic.show(bufnr) end,
      },
      {
        mode="n",
        shortcut="<leader>vca",
        mapper_cmd_OR_function=function() vim.lsp.buf.code_action() end,
        opts = opts,
        desc = "perform LSP related code action"
      },
      {
        mode="n",
        shortcut="<leader>fr",
        mapper_cmd_OR_function=function() vim.lsp.buf.references() end,
        opts = opts,
        desc = "find all references"
      },
      {
        mode="n",
        shortcut="<leader>vrn",
        mapper_cmd_OR_function=function() vim.lsp.buf.rename() end,
        opts = opts,
        desc = "rename variable across usages"
      },
      {
        mode="i",
        shortcut = "<C-h>",
        mapper_cmd_OR_function = function() vim.lsp.buf.signature_help() end,
        opts = opts,
        desc = "details of the variable under cursor"
      }
    }

    shortcut_utils.shortcuts_table_TO_keymaps{shortcuts =all_shortcuts}
end


vim.api.nvim_create_autocmd("LspAttach", {
    desc = "neovim lsp configurations",
    callback = attach_lsp_bindings
})


local lspconfig = require("lspconfig")
local default_setup = function(server)
    local function find_root_dir()
      return vim.fn.getcwd()
    end
    nvim_lsp(server, {
      root_dir = find_root_dir
    })
    lspconfig[server].setup(nvim_lsp[server])
end

M.setup = function (opts)
    opts = opts or {}

    local required_lsp = opts.required_lsp or {}

    for _, lsp in ipairs(required_lsp) do
      default_setup(lsp)
    end
    require('mason').setup()
    require("mason-lspconfig").setup({
        ensure_installed = required_lsp,
        automatic_enable = true
      });
    end

return M
