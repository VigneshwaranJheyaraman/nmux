-- color schema ROSEPINE
return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    main = "vickysuraj.setup.color_scheme",
    config = true
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }
}
