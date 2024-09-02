-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- rust thing
local util = require("lspconfig/util")

local lspconfig = require("lspconfig")
local servers = { "html", "cssls" }
local servers_python = { "pyright", "ruff_lsp" }
local servers_web = { "tsserver", "tailwindcss", "eslint" }

-- web-custom ????
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

-- rust
--lspconfig.rust_analyzer.setup {
--  on_attach = on_attach,
--  on_init = on_init,
--  capabilities = capabilities,
--  filetypes = { "rust" },
--  root_dir = util.root_pattern "Cargo.toml",
--  settings = {
--    ["rust_analyzer"] = {
--      Cargo = {
--        allFeatures = true,
--      },
--    },
--  },
--}

-- web-custom
for _, lsp in ipairs(servers_web) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		on_init = on_init,
		commands = {
			OrganizeImports = {
				organize_imports,
				description = "Organize Imports",
			},
		},
	})
end

-- go
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	on_init = on_init,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end

-- python
for _, lsp in ipairs(servers_python) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "python" },
	})
end

-- typescript
--lspconfig.tsserver.setup {
--  on_attach = on_attach,
--  on_init = on_init,
--  capabilities = capabilities,
--}

-- cpp
lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		-- Remove the line disabling signatureHelpProvider
		-- client.server_capabilities.signatureHelpProvider = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})
