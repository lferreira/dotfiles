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
require("luiz.plugins.toggleterm")
require("luiz.plugins.gitsigns")
require("luiz.plugins.lsp.go")

-- Run gofmt + goimport on save

--local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = "*.go",
--	callback = function()
--		require("gopls").goimport()
--	end,
--	group = format_sync_grp,
--})
