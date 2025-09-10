return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            {
                'saghen/blink.cmp',

                -- use a release tag to download pre-built binaries
                version = '1.*',

                ---@module 'blink.cmp'
                ---@type blink.cmp.Config
                opts = {
                    keymap = { preset = 'default' },

                    appearance = {
                        -- use_nvim_cmp_as_default = true,

                        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                        -- Adjusts spacing to ensure icons are aligned
                        nerd_font_variant = 'mono'
                    },

                    -- Default list of enabled providers defined so that you can extend it
                    -- elsewhere in your config, without redefining it, due to `opts_extend`
                    sources = {
                        default = { 'lsp', 'path', 'snippets', 'buffer', 'markdown' },
                        per_filetype = {
                            sql = { 'snippets', 'dadbod', 'buffer' },
                        },
                        -- add vim-dadbod-completion to your completion providers
                        providers = {
                            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                            markdown = {
                              name = 'RenderMarkdown',
                              module = 'render-markdown.integ.blink',
                              fallbacks = { 'lsp' },
                            },
                        },
                    },
                },
                opts_extend = { "sources.default" }
            },
        },
        config = function()
            local lsp_default_capabilities = require("blink.cmp").get_lsp_capabilities()
            require("vickysuraj.setup.lsp").setup {
                capabilities = lsp_default_capabilities,
                required_lsp = require("vickysuraj.utils.lsp").required_lsp
            }
        end
    }
}
