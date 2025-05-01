vim.opt.completeopt = { "menu", "menuone", "noselect" }

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local lspkind = require("lspkind")
local cmp = require("cmp")

local function tab_complete(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end

local function shift_tab_complete(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- Scrolling docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Invoke completion
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Abort completion
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm selection
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Tab completion
        ["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(shift_tab_complete, { "i", "s" }),

        -- Pass <Up>/<Down> to Neovim directly
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),

    formatting = {
        fields = { "abbr", "kind" },
        format = function(_, vim_item)
            local orig_kind = vim_item.kind
            local icon = lspkind.presets.default[orig_kind] or orig_kind
            vim_item.kind = string.format("%s %s", icon, orig_kind)
            return vim_item
        end,
    },

    window = {
        completion = cmp.config.window.bordered({
            border = "single",
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

return {
    capabilities = capabilities,
}
