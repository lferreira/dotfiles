-- Suppress deprecation warnings
vim.deprecate = function() end

-- Load only the essential setup first
require("luiz.plugins-setup")
require("luiz.core.global")
require("luiz.core.options")
require("luiz.core.colorscheme")
require("luiz.core.keymaps")
require("luiz.plugins.nvim-tree")
require("luiz.plugins.lualine")
require("luiz.plugins.telescope")
require("luiz.plugins.lsp.mason")
require("luiz.plugins.lsp.lspconfig")
require("luiz.plugins.lsp.null-ls")
require("luiz.plugins.nvim-cmp")
require("luiz.plugins.autopairs")
require("luiz.plugins.treesitter")
require("luiz.plugins.gitsigns")
require("luiz.plugins.lsp.go")
require("luiz.plugins.pomodoro")

-- Load plugin configurations only after plugins are installed
-- These will be loaded by the packer_compiled.lua file after PackerSync
