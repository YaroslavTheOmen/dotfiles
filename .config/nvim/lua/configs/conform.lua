local conform = require("conform")

local prettierd_filetypes = {
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

local formatters_by_ft = {
    lua = { "stylua" },
    python = { "yapf" },
    go = { "gofumpt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    sql = { "sql_formatter" },
    solidity = { "forge_fmt" },
}

for _, ft in ipairs(prettierd_filetypes) do
    formatters_by_ft[ft] = { "prettierd" }
end

conform.setup({
    formatters_by_ft = formatters_by_ft,
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- Use LSP formatting if no formatter is defined
    },
})
