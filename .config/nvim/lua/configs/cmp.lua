pcall(vim.loader.enable)

-- Completion popup behaves like VS Code
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- Requirements
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Lazily load VS Code-style snippets
luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.filetype_extend("mysql", { "sql" })
luasnip.filetype_extend("postgresql", { "sql" })
luasnip.filetype_extend("pgsql", { "sql" })
luasnip.filetype_extend("sqlite", { "sql" })
luasnip.filetype_extend("plsql", { "sql" })

-- <Tab> helpers -----------------------------------------------------------
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

-- Capabilities for lspconfig ---------------------------------------------
local capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- MAIN nvim-cmp setup -----------------------------------------------------
cmp.setup({
    preselect = cmp.PreselectMode.None,

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping(function(fallback)
            fallback()
        end, { "i", "s" }),
        ["<Down>"] = cmp.mapping(function(fallback)
            fallback()
        end, { "i", "s" }),
        ["<Left>"] = cmp.mapping(function(fallback)
            fallback()
        end, { "i", "s" }),
        ["<Right>"] = cmp.mapping(function(fallback)
            fallback()
        end, { "i", "s" }),

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
        { name = "buffer", keyword_length = 3 },
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

    experimental = { ghost_text = false },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "postgresql", "pgsql", "sqlite", "plsql" },
    callback = function()
        local ok, cmp = pcall(require, "cmp")
        if not ok then
            return
        end

        cmp.setup.buffer({
            sources = cmp.config.sources({
                { name = "vim-dadbod-completion" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer", keyword_length = 3 },
            }),
        })

        vim.bo.omnifunc = "vim_dadbod_completion#omni"

        -- optional: pass DB URL to dadbod for this buffer
        if vim.env.DATABASE_URL and not vim.b.db then
            vim.b.db = vim.env.DATABASE_URL
        end
    end,
})

cmp.setup.filetype("toml", {
    sources = {
        { name = "crates" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
    },
})

-- Extra setups -----------------------------------------------------------
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
})

-- Export for lspconfig.lua -----------------------------------------------
return { capabilities = capabilities }
