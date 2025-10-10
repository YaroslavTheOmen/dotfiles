return {

    -- ► A. nvim-cmp  ----------------------------------------------------------
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
            require("configs.cmp")
        end,
    },

    -- ► B. Blink (commented − enable if you use it) --------------------------
    -- { import = "nvchad.blink.lazyspec" },
    -- { "Saghen/blink.cmp", opts = {} },

    -- ► C. Core LSP / Mason stack -------------------------------------------
    {
        "neovim/nvim-lspconfig",
        dependencies = { "b0o/schemastore.nvim" },
        config = function()
            require("configs.lspconfig")
        end,
    },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },

    -- ► D. UI & NvChad core --------------------------------------------------
    "nvim-lua/plenary.nvim",
    {
        "nvchad/ui",
        config = function()
            require("nvchad")
        end,
    },
    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    { "nvchad/showkeys", cmd = "ShowkeysToggle" },

    -- ► E. Misc NvChad v3 extras --------------------------------------------
    { "nvzone/volt", lazy = true },
    { "nvzone/menu", lazy = true },
    { "nvzone/minty", cmd = { "Shades", "Huefy" } },

    -- ► F. Utilities ---------------------------------------------------------
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        init = function()
            vim.g.lazygit_floating_window_use_plenary = 0
        end,
    },
    { "akinsho/toggleterm.nvim", version = "*", event = "VeryLazy", config = true },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
            dofile(vim.g.base46_cache .. "trouble")
            require("trouble").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        config = function(_, opts)
            require("todo-comments").setup(opts)
        end,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        tag = "stable",
        config = function()
            require("crates").setup({
                completion = {
                    cmp = { enabled = true },
                    crates = {
                        enabled = true,
                        min_chars = 2,
                        max_results = 10,
                    },
                },
            })
        end,
    },

    -- ► G. Formatting / linting ---------------------------------------------
    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("configs.none-ls")
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            require("configs.nvim-lint")
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    -- ► H. Treesitter + extras ----------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c",
                "cmake",
                "cpp",
                "css",
                "dockerfile",
                "go",
                "html",
                "javascript",
                "lua",
                "python",
                "rust",
                "solidity",
                "sql",
                "tsx",
                "typescript",
                "vim",
            },
            auto_install = true,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "xml",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- ► I. Language-specific helpers ----------------------------------------
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function(_, opts)
            require("gopher").setup(opts)
        end,
        build = function()
            vim.cmd([[silent! GoInstallDeps]])
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
    },

    -- ► J. Git ---------------------------------------------------------------
    { "tpope/vim-fugitive", event = "VeryLazy" },

    -- ► K. JSON / YAML schemas ----------------------------------------------
    { "b0o/schemastore.nvim", lazy = true },

    -- ► L. X-Ray signature helper with syntax-highlighting
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = { border = "rounded" },
            floating_window = true,
            floating_window_above_cur_line = true,
            max_width = 100,
            wrap = true,
            hint_enable = false,
            toggle_key = "<M-x>",
            move_cursor_key = "<C-s>",
            hi_parameter = "LspSignatureActiveParameter",
        },
        config = function(_, opts)
            require("lsp_signature").setup(opts)
            -- reuse cmp’s matched-text highlight for active parameter
            vim.cmd("hi! link LspSignatureActiveParameter CmpItemAbbrMatch")
        end,
    },

    -- ► M. SQL
    { "tpope/vim-dadbod", lazy = true },

    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql", "postgresql", "pgsql", "sqlite" },
        dependencies = { "tpope/vim-dadbod" },
    },
}
