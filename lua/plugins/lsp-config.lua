return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ast_grep", "jdtls", "lua_ls", "gopls", "pyright", "rust_analyzer" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local on_attach = function(_, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
				vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, {})
			end
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					})
				end,
			})
			lspconfig.ast_grep.setup({})
			lspconfig.jdtls.setup({})
			lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.rust_analyzer.setup({})
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})
			lspconfig.pyright.setup({})
		end,
	},
}
