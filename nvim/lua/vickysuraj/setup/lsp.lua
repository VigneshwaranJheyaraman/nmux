local M = {}
local nvim_lsp = require('lspconfig')
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


local default_setup = function(server, lsp_default_capabilities)
    nvim_lsp[server].setup({
        capabilities = lsp_default_capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end
    })
end

M.setup = function (opts)
    opts = opts or {}

    local lsp_default_capabilities = opts.capabilities
    assert(lsp_default_capabilities)

    local required_lsp = opts.required_lsp or {}

    M.rl = required_lsp

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = required_lsp,
        automatic_installation = true,
        handlers={
            function (server)
                default_setup(server, lsp_default_capabilities)
            end,
            eslint = function ()
                require('lspconfig').eslint.setup({
                    capabilities = lsp_default_capabilities,
                    on_attach = function (_, buffer)
                        -- make sure before saving a file eslint fix all
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = buffer,
                            command= "EslintFixAll"
                        })
                    end
                })
            end,
            lua_ls = function()
                local runtime_path = vim.split(package.path, ';')
                table.insert(runtime_path, "lua/?.lua")
                table.insert(runtime_path, "lua/?/init.lua")
                local lua_opts = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = runtime_path
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        }
                    }
                }
                require('lspconfig').lua_ls.setup({
                    capabilities = lsp_default_capabilities,
                    settings = lua_opts,
                })
            end,
        }});
    end

return M
