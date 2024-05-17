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
    vim.keymap.set("n", "<leader>gb", function() vim.cmd("b#") end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "neovim lsp configurations",
    callback = attach_lsp_bindings
})

local lsp_default_capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_setup = function(server)
    nvim_lsp[server].setup({
        capabilities = lsp_default_capabilities,
        root_dir = function()
            return vim.fn.getcwd()
        end
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'eslint', 'tsserver', 'clojure_lsp', 'jdtls', 'lua_ls', 'jsonls'},
  handlers = {
    default_setup,
    eslint = function ()
        require('lspconfig').eslint.setup({
            capabilities = lsp_default_capabilities,
            on_attach = function (_, buffer)
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
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
      expand = function(args)
          require("luasnip").lsp_expand(args.body)
      end
  }
})

-- vim dadbod to enable completion for SQL commands and variables from file buffer
cmp.setup.filetype( { "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})
