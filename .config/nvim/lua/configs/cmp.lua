-- Neovim option that lets the popup behave like VS Code
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Requirements
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind") -- ✨ pictograms
local autopairs = require("nvim-autopairs.completion.cmp")

-- Load vscode-style snippets **lazily** (only when first used)
luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
require("luasnip.loaders.from_vscode").lazy_load()

-- Helper functions for <Tab> / <S-Tab>
local function tab_complete(fallback)
    if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end

local function shift_tab_complete(fallback)
    if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

-- Export these capabilities to your LSP config
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Main cmp setup
cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- manual trigger
        ["<C-e>"] = cmp.mapping.abort(), -- close menu
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(shift_tab_complete, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 }, -- start after 3 chars
    }),

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "…",
            show_labelDetails = true,
        }),
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        ghost_text = { hl_group = "Comment" }, -- unobtrusive grey
    },
})

-- Extra setups
-- 1. Auto-insert parens/quotes for functions etc.
cmp.event:on("confirm_done", autopairs.on_confirm_done())

-- 2. Command-line completion
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- 3. Filetype-specific tweaks (example: gitcommit)
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" },
    }, {
        { name = "buffer" },
    }),
})

-- Export for use in lspconfig.lua
return {
    capabilities = capabilities,
}
