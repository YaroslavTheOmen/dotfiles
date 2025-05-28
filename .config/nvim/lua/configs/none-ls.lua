-- Diagnostics / code-actions via none-ls
local null = require("none-ls")

-- helpers
local function python_exec()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    return venv .. "/bin/python3"
end

-- setup
null.setup({
    sources = {

        --  diagnostics
        null.builtins.diagnostics.mypy.with({
            extra_args = function()
                return { "--python-executable", python_exec() }
            end,
        }),

        null.builtins.diagnostics.eslint_d, -- js / ts
        null.builtins.diagnostics.solhint, -- solidity
        null.builtins.diagnostics.sqlfluff.with({
            extra_args = {
                "lint",
                "-f",
                "parsable",
                "--dialect",
                "ansi",
                "-",
                "--nofailon",
                "warn",
            },
        }),

        null.builtins.diagnostics.luacheck.with({
            extra_args = { "--globals", "vim", "--std", "lua51", "--codes", "--no-color", "-" },
        }),

        null.builtins.diagnostics.golangci_lint, -- go

        --  (no formatters here – Conform handles them)
    },
})
