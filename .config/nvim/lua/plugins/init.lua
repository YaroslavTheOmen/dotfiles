return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },

  { "williamboman/mason-lspconfig.nvim" },

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
        "bash",
        "fish",
      },
    },
  },

  {
    "nvzone/volt",
    lazy = true,
  },

  {
    "nvzone/menu",
    lazy = true,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    init = function()
      vim.g.lazygit_floating_window_use_plenary = 0
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = true,
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

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
}
