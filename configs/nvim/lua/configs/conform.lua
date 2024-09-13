local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    html = { "prettier" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    python = { "black" },
    rust = { "rustfmt" },
    go = { "gofumpt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
