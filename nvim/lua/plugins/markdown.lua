return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    ft = { "markdown" }
  },
  {
    'barrettruth/preview.nvim',
    lazy = true,
    config = vim.fn.executable("pandoc"),
    ft = { "markdown" }
  }
}
