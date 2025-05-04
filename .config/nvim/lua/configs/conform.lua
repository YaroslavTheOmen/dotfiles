local conform = require("conform")

-- 1. Define which filetypes use 'prettierd'
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

-- 2. Build the formatters_by_ft table, starting with unique assignments
local formatters_by_ft = {
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

-- 3. Assign 'prettierd' to each filetype in 'prettierd_filetypes'
for _, ft in ipairs(prettierd_filetypes) do
    formatters_by_ft[ft] = { "prettierd" }
end

-- 4. Set up Conform with the final table
conform.setup({
    formatters_by_ft = formatters_by_ft,
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- Use LSP formatting if no formatter is defined
    },
})
