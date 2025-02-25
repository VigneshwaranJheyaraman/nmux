-- color schema ROSEPINE
return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.keymap.set("n", "<leader>pine", function()
                require("vickysuraj.mappings.color_scheme").ColorMyBash("rose-pine")
            end)
        end
    }
}
