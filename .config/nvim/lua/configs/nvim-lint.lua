pcall(vim.loader.enable)

-- Gracefully fail if nvim-lint is missing (e.g. during first :Lazy sync)
local ok, lint = pcall(require, "lint")
if not ok then
    vim.notify("nvim-lint not found!", vim.log.levels.ERROR)
    return
end

-- 1.  Custom CLI arguments per linter
lint.linters.luacheck.args = {
    "--globals",
    "vim",
    "--std",
    "lua51",
    "--codes",
    "--no-color",
    "-",
}

lint.linters.solhint.args = { "--max-warnings", "0", "--stdin" }

lint.linters.sqlfluff.args = {
    "lint",
    "-f",
    "parsable",
    "--dialect",
    "ansi",
    "--nofailon",
    "warn",
    "-",
}

-- 2.  Map filetypes → linters
lint.linters_by_ft = {
    --lua = { "luacheck" },
    --go = { "golangci_lint" },
    --solidity = { "solhint" },
    --sql = { "sqlfluff" },
}

-- 3.  Run the appropriate linter(s) on every write
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
    callback = function()
        -- nvim-lint figures out the correct linter(s) from linters_by_ft
        -- and spawns them asynchronously
        lint.try_lint()
    end,
})
