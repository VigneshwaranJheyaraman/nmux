return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function ()
      vim.keymap.set("n", "<leader>md", vim.cmd("RenderMarkdown"))
    end
  }
}
