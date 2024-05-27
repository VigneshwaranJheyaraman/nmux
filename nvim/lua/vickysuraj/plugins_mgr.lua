vim.cmd [[packadd packer.nvim]]

-- Add your plugins here one after another

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Telescope helps with fuzzy finding and searching the files
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- tree sitter will help us build better Abstract Syntax tree
  use {
      'nvim-treesitter/nvim-treesitter',
      run= ':TSUpdate'
  }
  -- color schme plugin which gives a pleasent env
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use 'HiPhish/rainbow-delimiters.nvim'
  --- uncomment these if you want to manage lsp servers from neovim
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- lsp support
  use {
      'neovim/nvim-lspconfig',
      tag='v0.1.7'
  }
  -- autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'l3mon4d3/luasnip'
  -- db completion dadbod
  use 'tpope/vim-dadbod'
  use 'tpope/vim-dotenv'
  use 'kristijanhusak/vim-dadbod-ui'
  use 'kristijanhusak/vim-dadbod-completion'
end)
