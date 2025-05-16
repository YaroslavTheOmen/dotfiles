local conform = require "conform"

-- filetypes that use PrettierD
local prettierd_ft = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "html",
  "css",
  "scss",
  "json",
  "yaml",
  "markdown",
}

-- base table
local fmt = {
  lua = { "stylua" },
  python = { "yapf" },
  go = { "gofumpt" },
  c = { "clang_format" },
  cpp = { "clang_format" },
  rust = { "rustfmt" },
  sql = { "sql_formatter" },
  cmake = { "cmakelang" },
  solidity = { "forge_fmt" },
}

-- add Prettierd to the web stack
for _, ft in ipairs(prettierd_ft) do
  fmt[ft] = { "prettierd" }
end

-- setup
conform.setup {
  formatters_by_ft = fmt,

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true, -- use LSP when no dedicated formatter
  },
}
