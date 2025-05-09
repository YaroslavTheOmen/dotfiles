return {
    -- v3.0 plugin
    "nvim-lua/plenary.nvim",
    {
        "nvchad/ui",
        config = function()
            require("nvchad")
        end,
    },

    -- v3.0 plugin
    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    -- v3.0 plugin
    { "nvzone/volt", lazy = true },

    -- v3.0 plugin
    { "nvzone/menu", lazy = true },

    -- v3.0 plugin
    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },

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

    -- toggleterm
    { "akinsho/toggleterm.nvim", version = "*", config = true, event = "VeryLazy" },

    -- v3.0
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
            dofile(vim.g.base46_cache .. "trouble")
            require("trouble").setup()
        end,
    },

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

    -- none-ls
    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("configs.none-ls")
        end,
    },

    -- nvim-lint
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            require("configs.nvim-lint")
        end,
    },

    -- conform
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
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
            vim.cmd([[silent! GoInstallDeps]])
        end,
    },

    -- RustaceanVim for Rust development
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        ft = { "rust" },
        dependencies = "neovim/nvim-lspconfig",
    },

    -- nvim-lspconfig with schemastore
    {
        "neovim/nvim-lspconfig",
        dependencies = { "b0o/schemastore.nvim" },
        config = function()
            require("configs.lspconfig")
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
            require("configs.cmp")
        end,
    },
}
