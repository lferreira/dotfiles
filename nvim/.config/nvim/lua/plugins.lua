return require('packer').startup(function(use)
 -- Configurations will go here
 use 'wbthomason/packer.nvim'
 use 'williamboman/mason.nvim'   
 use 'williamboman/mason-lspconfig.nvim'
 use 'neovim/nvim-lspconfig'
 -- Hrsh7th Code Completion Suite
 use 'hrsh7th/nvim-cmp' 
 use 'hrsh7th/cmp-nvim-lsp'
 use 'hrsh7th/cmp-nvim-lua'
 use 'hrsh7th/cmp-nvim-lsp-signature-help'
 use 'hrsh7th/cmp-vsnip'                             
 use 'hrsh7th/cmp-path'                              
 use 'hrsh7th/cmp-buffer'                            
 use 'hrsh7th/vim-vsnip'
 -- File explorer tree
 use {
  'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
 }

 -- Nord theme for styling  https://github.com/shaunsingh/nord.nvim
 use 'shaunsingh/nord.nvim'

 -- Treesitter
 use {
  -- recommended packer way of installing it is to run this function, copied from documentation
         'nvim-treesitter/nvim-treesitter',
      run = function()
              local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
              ts_update()
         end,

 }
-- Telescope used to fuzzy search files
 use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
 }
-- Lualine information / Status bar
 use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
 }
end)
