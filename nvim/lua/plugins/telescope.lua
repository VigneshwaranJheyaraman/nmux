return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    -- naming is weird because i don't want to cause warn on same naming required
    -- The same file is required with different names.
    main = "vickysuraj.setup.teleScope",
    config = true
  },
  { 'nvim-lua/plenary.nvim',                    lazy = true },
  { "folke/todo-comments.nvim",                 lazy = true },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }

}
