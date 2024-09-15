-- ~/.config/nvim/lua/custom/chadrc.lua
---@type ChadrcConfig
local options = {

  base46 = {
    theme = "one_light", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    transparency = false,
    theme_toggle = { "catppuccin", "one_light" }, -- toggle between these themes
  },

  ui = {
    cmp = {
      icons = true,
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil, -- custom order can be specified
      modules = nil, -- custom modules can be added
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true, -- enable bufferline
      lazyload = true, -- lazyload when there's more than one buffer
      order = { "treeOffset", "buffers", "tabs", "btns" }, -- order of components in the tabline
      modules = nil, -- additional modules can be added
    },

    nvdash = {
      load_on_startup = true, -- nvdash starts on startup

      header = {
        "  ▄▄         ▄ ▄▄▄▄▄▄▄ ",
        "▄▀███▄     ▄██ █████▀  ",
        "██▄▀███▄   ███         ",
        "███  ▀███▄ ███         ",
        "███    ▀██ ███         ",
        "███      ▀ ███         ",
        "▀██ █████▄▀█▀▄██████▄  ",
        "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀ ",
      },

      buttons = {
        { "  Find File", "Spc f f", "Telescope find_files" },
        { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
        { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
        { "  Bookmarks", "Spc m a", "Telescope marks" },
        { "  Themes", "Spc t h", "Telescope themes" },
        { "  Mappings", "Spc c h", "NvCheatsheet" },
      },
    },
  },

  term = {
    winopts = { number = false, relativenumber = false }, -- disable line numbers in terminal
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 }, -- size configuration for splits
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single", -- single border for floating windows
    },
  },

  lsp = { signature = true }, -- enable LSP signature

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- exclude these groups from cheatsheet
  },

  mason = {
    cmd = true, -- enable command mode for mason
    pkgs = {
      -- extra
      "luacheck",

      -- Language Servers
      "lua-language-server",
      "html-lsp",
      "css-lsp",
      "typescript-language-server",
      "tailwindcss-language-server",
      "pyright",
      "ruff-lsp",
      "rust-analyzer",
      "gopls",
      "clangd",

      -- Formatters
      "stylua",
      "prettierd",
      "clang-format",
      "black",
      "gofumpt",
      "rustfmt",

      -- Linters
      "mypy",
      "eslint_d",
      "luacheck",
      "golangci-lint",
    },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
