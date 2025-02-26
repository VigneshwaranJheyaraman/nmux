local telescope_mappings = {}

telescope_mappings.setup = function (opts)
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set("n", "<leader>fgf", builtin.git_files, {})
    vim.keymap.set('n', '<leader>gf', function()
        builtin.grep_string({search = vim.fn.input("Grep > ")})
    end, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    -- edit neovim's configuration
    vim.keymap.set("n", "<leader><leader>nvim", function ()
        builtin.find_files {
            cwd = vim.fn.stdpath("config")
        }
    end)
    -- load multigrep
    require("vickysuraj.mappings.multigrep").setup ();
end

return telescope_mappings
