return {
  {
    'tpope/vim-dadbod',
    priority = 5000
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    main = "vickysuraj.setup.db",
    opts = {},
    commands = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
      'StartDb'
    }
  },
  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }
}
