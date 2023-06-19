---- import luasnip plugin safely
--local luasnip_status, luasnip = pcall(require, "luasnip")
--if not luasnip_status then
--	return
--end
--
--

local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
	return
end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then
	return
end

local lspconfig_setup, lspconfig = pcall(require, "lspconfig")
if not lspconfig_setup then
	return
end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then
	return
end

vim.opt.completeopt = "menu,menuone,noselect,preview"

-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true }

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	--	-- sources are the installed sources that can be used for code suggestions
	--	sources = {
	--		{ name = "path" },
	--		{ name = "nvim_lsp", keyword_length = 3 },
	--		{ name = "nvim_lsp_signature_help" },
	--		{ name = "nvim_lua", keyword_length = 2 },
	--		{ name = "buffer", keyword_length = 2 },
	--		{ name = "vsnip", keyword_length = 2 },
	--	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
	}, {
		{ name = "path" },
		{ name = "buffer" },
	}),
})

local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			staticcheck = true,
			analyses = {
				assign = true,
				atomic = true,
				bools = true,
				composites = true,
				copylocks = true,
				deepequalerrors = true,
				embed = true,
				errorsas = true,
				fieldalignment = true,
				httpresponse = true,
				ifaceassert = true,
				loopclosure = true,
				lostcancel = true,
				nilfunc = true,
				nilness = true,
				nonewvars = true,
				printf = true,
				shadow = true,
				shift = true,
				simplifycompositelit = true,
				simplifyrange = true,
				simplifyslice = true,
				sortslice = true,
				stdmethods = true,
				stringintconv = true,
				structtag = true,
				testinggoroutine = true,
				tests = true,
				timeformat = true,
				unmarshal = true,
				unreachable = true,
				unsafeptr = true,
				unusedparams = true,
				unusedresult = true,
				unusedvariable = true,
				unusedwrite = true,
				useany = true,
			},
			hoverKind = "FullDocumentation",
			linkTarget = "pkg.go.dev",
			usePlaceholders = true,
			vulncheck = "Imports",
		},
	},
})

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,

			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

--cmp.setup({
--
--	-- Add Mappings to control the code suggestions
--	mapping = {
--		-- Shift+TAB to go to the Previous Suggested item
--		["<S-Tab>"] = cmp.mapping.select_prev_item(),
--		-- Tab to go to the next suggestion
--		["<Tab>"] = cmp.mapping.select_next_item(),
--		-- CTRL+SHIFT+f to scroll backwards in description
--		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
--		-- CTRL+F to scroll forwards in the description
--		["<C-f>"] = cmp.mapping.scroll_docs(4),
--		-- CTRL+SPACE to bring up completion at current Cursor location
--		["<C-Space>"] = cmp.mapping.complete(),
--		-- CTRL+e to exit suggestion and close it
--		["<C-e>"] = cmp.mapping.close(),
--		-- CR (enter or return) to CONFIRM the currently selection suggestion
--		-- We set the ConfirmBehavior to insert the Selected suggestion
--		["<CR>"] = cmp.mapping.confirm({
--			behavior = cmp.ConfirmBehavior.Insert,
--			select = true,
--		}),
--	},
