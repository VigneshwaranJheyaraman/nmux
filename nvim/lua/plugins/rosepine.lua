local alawys_italic_and_bold = { bold = true, italic = true }
-- color schema ROSEPINE
return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {},
    lazy = true,
  },
  {
    "oskarnurm/koda.nvim",
    name = 'koda',
    lazy = true,
    opts = {
      styles = {
        functions = alawys_italic_and_bold,
        keywords  = alawys_italic_and_bold,
        comments  = {},
        strings   = {},
        constants = {}, -- includes numbers, booleans
      },
    },
  }
}
