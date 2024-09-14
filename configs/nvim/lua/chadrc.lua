-- ~/.config/nvim/lua/custom/chadrc.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "one_light",
}

M.mason = {
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
    -- "clang-tidy",
  },
}

return M
