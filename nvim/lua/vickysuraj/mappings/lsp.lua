local M = {}
local nvim_lsp = require('lspconfig')

local function attach_lsp_bindings(event)
    local bufnr = event.buf
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>fr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
