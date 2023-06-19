require("luiz.plugins-setup")
require("luiz.core.options")
require("luiz.core.keymaps")
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

-- Run gofmt + goimport on save

--local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = "*.go",
--	callback = function()
--		require("gopls").goimport()
--	end,
--	group = format_sync_grp,
--})

--
--local opt = vim.opt
--local g = vim.g
--
---------------------------------------- globals -----------------------------------------
--g.toggle_theme_icon = "   "
--
---------------------------------------- options ------------------------------------------
--opt.laststatus = 3 -- global statusline
--opt.showmode = false
--
--opt.clipboard = "unnamedplus"
--opt.cursorline = true
--
---- Indenting
--opt.expandtab = true
--opt.shiftwidth = 2
--opt.smartindent = true
--opt.tabstop = 2
--opt.softtabstop = 2
--
--opt.fillchars = { eob = " " }
--opt.ignorecase = true
--opt.smartcase = true
--opt.mouse = "a"
--
---- Numbers
--opt.number = true
--opt.numberwidth = 2
--opt.ruler = false
--
---- disable nvim intro
--opt.shortmess:append "sI"
--
--opt.signcolumn = "yes"
--opt.splitbelow = true
--opt.splitright = true
--opt.termguicolors = true
--opt.timeoutlen = 400
--opt.undofile = true
--
---- interval for writing swap file to disk, also used by gitsigns
--opt.updatetime = 250
--
---- go to previous/next line with h,l,left arrow and right arrow
---- when cursor reaches end/beginning of line
--opt.whichwrap:append "<>[]hl"
--
--g.mapleader = " "
--
---- disable some default providers
--for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
--  vim.g["loaded_" .. provider .. "_provider"] = 0
--end
--
---- add binaries installed by mason.nvim to path
--local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
--vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
--
---------------------------------------- autocmds ------------------------------------------
--local autocmd = vim.api.nvim_create_autocmd
--
---- dont list quickfix buffers
--autocmd("FileType", {
--  pattern = "qf",
--  callback = function()
--    vim.opt_local.buflisted = false
--  end,
--})
