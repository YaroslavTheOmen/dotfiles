-- Set completeopt
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Load LuaSnip
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- Load lspkind for symbols
local lspkind = require("lspkind")

-- Setup nvim-cmp
local cmp = require("cmp")

-- Setup capabilities for LSP (to be used in LSP setup)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Up>"] = cmp.mapping(function(fallback)
			fallback()
		end, { "i", "s" }),
		["<Down>"] = cmp.mapping(function(fallback)
			fallback()
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		--{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "buffer", group_index = 2 },
		{ name = "path", group_index = 2 },
	}),
	--sorting = {
	--	priority_weight = 2,
	--	comparators = {
	--		require("copilot_cmp.comparators").prioritize,
	--
	--		-- Below is the default comparator list and order for nvim-cmp
	--		cmp.config.compare.offset,
	--		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
	--		cmp.config.compare.exact,
	--		cmp.config.compare.score,
	--		cmp.config.compare.recently_used,
	--		cmp.config.compare.locality,
	--		cmp.config.compare.kind,
	--		cmp.config.compare.sort_text,
	--		cmp.config.compare.length,
	--		cmp.config.compare.order,
	--	},
	--},
	window = {
		completion = cmp.config.window.bordered({
			border = "single", -- Customize as needed ("single", "rounded", etc.)
			col_offset = 0,
			side_padding = 1,
		}),
		documentation = cmp.config.window.bordered({
			border = "single",
		}),
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
})

-- Setup for command-line mode completions
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
