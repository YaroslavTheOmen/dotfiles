pcall(vim.loader.enable)

local ok, conform = pcall(require, "conform")
if not ok then
    vim.notify("conform.nvim not found!", vim.log.levels.ERROR)
    return
end

-- 1.  Filetypes that share the Prettier  ecosystem (served by *prettierd*)
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

-- 2.  Base formatter table  (unchanged from your original)
local formatters_by_ft = {
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
}

-- 3.  Add Prettier-powered stacks
for _, ft in ipairs(prettierd_ft) do
    formatters_by_ft[ft] = { "prettierd" }
end

-- 4.  Setup
conform.setup({
    formatters_by_ft = formatters_by_ft,

    format_on_save = function(bufnr)
        local ok_stat, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok_stat and stat and stat.size > 512 * 1024 then
            return
        end
        return { timeout_ms = 1000, lsp_fallback = true }
    end,

    formatters = {
        prettierd = {
            env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/.prettierrc.json") },
        },
    },
})

-- 5.  Manual :Format command for the rare case you disable format-on-save
vim.api.nvim_create_user_command("Format", function()
    conform.format({ timeout_ms = 1000, lsp_fallback = true })
end, {})
