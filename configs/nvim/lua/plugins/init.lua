local cmp = require "cmp"

return {

  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  --none.ls
  {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    opts = function()
      return require "configs.none-ls"
    end,
  },

  --web-custom
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  --go
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

  --rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "configs.rustaceanvim"
    end,
  },

  --BASE
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" }, -- Add schemastore as a dependency
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- PLUGINS
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- web
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "prettierd",
        -- cpp
        "clangd",
        "clang-format",
        -- python
        "pyright",
        "ruff-lsp",
        "mypy",
        "black",
        -- rust
        "rust-analyzer",
        "rustfmt",
        -- go
        "gopls",
        "gofumpt",
        -- web-custom
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- web
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        -- general
        "c",
        "cpp",
        "python",
        "rust",
        "go",
      },
    },
  },

  -- Git
  { "tpope/vim-fugitive", event = "VeryLazy" }, -- Git control for vim

  -- Strange config for gitsigns
  --{
  --  "lewis6991/gitsigns.nvim", -- git signs
  --  config = function()
  --    require("gitsigns").setup {
  --      signcolumn = false,
  --      status_formatter = function(status)
  --        local added, changed, removed = status.added, status.changed, status.removed
  --        local status_txt = {}
  --        if added and added > 0 then
  --          table.insert(status_txt, "+" .. added)
  --        end
  --        if changed and changed > 0 then
  --          table.insert(status_txt, "~" .. changed)
  --        end
  --        if removed and removed > 0 then
  --          table.insert(status_txt, "-" .. removed)
  --        end

  --        -- format the table with commas if there are multiple changes
  --        if #status_txt > 1 then
  --          for i = 2, #status_txt do
  --            status_txt[i] = "," .. status_txt[i]
  --          end
  --        end

  --        -- check if there are any changes
  --        if #status_txt > 2 then
  --          return string.format("[%s]", table.concat(status_txt))
  --        else
  --          return ""
  --        end
  --      end,
  --    }
  --  end,
  --},
  -- wilder

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
              if string.find(arg, ".") ~= nil then
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
  }, -- : autocomplete
}
