return {

  -- Base for NvChad
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvchad/showkeys", cmd = "ShowkeysToggle" },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 0 -- Disables floating terminal
    end,
  },
  -- vim-floaterm
  {
    "voldikss/vim-floaterm",
    event = "VeryLazy",
  },

  -- v3.0
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  -- Essential dependency
  "nvim-lua/plenary.nvim",

  -- todo comments
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    requires = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
  },

  -- NvChad UI plugin
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  -- NvChad Base46 plugin
  {
    "nvchad/base46",
    lazy = false,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  -- none-ls
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require "configs.none-ls"
    end,
  },

  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-lint"
    end,
  },

  -- conform
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  -- nvim-ts-autotag for web development
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Gopher for Go development
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  -- RustaceanVim for Rust development
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
  },

  -- nvim-lspconfig with schemastore
  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason for managing external tools
  {
    "williamboman/mason.nvim",
  },

  -- Treesitter for syntax highlighting

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "cpp",
        "python",
        "rust",
        "go",
      },
    },
  },

  -- Git integration
  { "tpope/vim-fugitive", event = "VeryLazy" },

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
    },
    config = function()
      -- Set completeopt
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      -- Load LuaSnip
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load lspkind for symbols
      local lspkind = require "lspkind"

      -- Setup nvim-cmp
      local cmp = require "cmp"

      -- Setup capabilities for LSP (to be used in LSP setup)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Tab Completion Configuration (Highly Recommended)
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end),

          -- dafault tab mapping
          --["<Tab>"] = cmp.mapping(function(fallback)
          --	if cmp.visible() then
          --		cmp.select_next_item()
          --	elseif luasnip.expand_or_jumpable() then
          --		luasnip.expand_or_jump()
          --	else
          --		fallback()
          --	end
          --end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "cmdline" },
        },
        window = {
          completion = cmp.config.window.bordered {
            border = "single", -- Customize as needed ("single", "rounded", etc.)
            -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
            -- scrollbar = false, -- Disable the scrollbar
            col_offset = 0,
            side_padding = 1,
          },
          documentation = cmp.config.window.bordered {
            border = "single",
            -- winhighlight = "Normal:CmpPmenuDoc,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
            -- scrollbar = false, -- Disable the scrollbar for documentation window
          },
        },
        experimental = {
          ghost_text = true,
          native_menu = false,
        },
      }

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
    end,
  },

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "LspAttach" },
    fix_pairs = true,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
