local lint = require("lint")

local luacheck = require("lint.linters.luacheck")
luacheck.args = {
    "--globals",
    "vim",
    "--std",
    "lua51",
    "--codes",
    "--no-color",
    "-",
}

local solhint = require("lint.linters.solhint")
solhint.args = {
    "--max-warnings",
    "0", -- or remove if you prefer to allow warnings
    "--stdin",
}

local sqlfluff = require("lint.linters.sqlfluff")
sqlfluff.args = {
    "lint",
    "-f",
    "parsable",
    "--dialect",
    "ansi", -- change to e.g. "postgres" or "mysql" if needed
    "--nofailon",
    "warn", -- treat warnings as not failing the lint
    "-",
}

local linters_by_ft = {
    lua = { "luacheck" },
    go = { "golangcilint" },
    solidity = { "solhint" },
    sql = { "sqlfluff" },
}

lint.linters_by_ft = linters_by_ft

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        lint.try_lint()
    end,
})
