return {
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

  -- Wilder for command-line completion
  {
    "gelguy/wilder.nvim",
    event = "VeryLazy",
    build = ":UpdateRemotePlugins",
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":", "/", "?" } }
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline {
            file_command = function(_, arg)
              if string.find(arg, ".") then
                return { "fd", "-tf", "-H" }
              else
                return { "fd", "-tf" }
              end
            end,
            dir_command = { "fd", "-td" },
            filters = { "fuzzy_filter", "difflib_sorter" },
          },
          wilder.cmdline_pipeline(),
          wilder.python_search_pipeline()
        ),
      })
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer {
          highlighter = wilder.basic_highlighter(),
          left = { " " },
          right = { " ", wilder.popupmenu_scrollbar { thumb_char = " " } },
          highlights = { default = "WilderMenu", accent = "WilderAccent" },
        }
      )
    end,
  },
}
