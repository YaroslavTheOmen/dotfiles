local options = {

  formatters_by_ft = {
    elixir = { "mix" },
    heex = { "mix" },
    surface = { "mix" },
    lua = { "stylua" },
    python = { "yapf" },
    go = { "gofumpt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    sql = { "sql_formatter" },
    cmake = { "cmake_format" },
    solidity = { "forge_fmt" },
    toml = { "taplo" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
