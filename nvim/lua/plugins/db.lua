return {
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
      'StartDB'
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    main = "vickysuraj.setup.db",
    opts = {},
  },
  { 'tpope/vim-dadbod',                     cmd = { "DBUI" } },
  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }
}
