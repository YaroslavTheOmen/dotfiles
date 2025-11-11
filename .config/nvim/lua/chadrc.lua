-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "one_light",
  theme_toggle = { "one_light", "catppuccin" },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

M.ui = {
  cmp = {
    icons_left = false,
    style = "default",
    abbr_maxwidth = 60,
    format_colors = {
      tailwind = true,
      icon = "󱓻",
    },
  },
  statusline = {
    enabled = true,
    theme = "vscode_colored",
    separator_style = "default",
    order = nil,
    modules = nil,
  },
}

M.mason = {
  cmd = true,
  pkgs = {

    -- LSPs
    "clangd",
    "cmake-language-server",
    "css-lsp",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "gopls",
    "elixir-ls",
    "html-lsp",
    "lua-language-server",
    "pyright",
    "ruff",
    -- "rust-analyzer",
    "solidity",
    "tailwindcss-language-server",
    "taplo",
    "typescript-language-server",
    "marksman",

    -- Formatters
    "clang-format",
    "cmakelang",
    "gofumpt",
    "prettierd",
    "sql-formatter",
    "stylua",
    "yapf",

    -- Linters
    "eslint_d",
    "golangci-lint",
    "luacheck",
    "mypy",
    "solhint",
    "sqlfluff",
  },
}

return M
