pcall(vim.loader.enable)

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})
require("luasnip.loaders.from_vscode").lazy_load()

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

local capabilities =
  require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
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
    format = function(_, item)
      return item
    end,
  },

  duplicates_default = 0,
  duplicates = { nvim_lsp = 1 },

  sorting = {
    comparators = {
      function(entry1, entry2)
        local s1, s2 = entry1.source.name, entry2.source.name
        if s1 ~= s2 then
          if s1 == "nvim_lsp" then
            return true
          end
          if s2 == "nvim_lsp" then
            return false
          end
        end
        return nil
      end,
      require("cmp.config.compare").score,
      require("cmp.config.compare").offset,
      require("cmp.config.compare").exact,
      require("cmp.config.compare").recently_used,
      require("cmp.config.compare").kind,
      require("cmp.config.compare").sort_text,
      require("cmp.config.compare").length,
      require("cmp.config.compare").order,
    },
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  experimental = { ghost_text = false },
})

cmp.setup.filetype("toml", {
  sources = {
    { name = "crates" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  },
})

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

return { capabilities = capabilities }
