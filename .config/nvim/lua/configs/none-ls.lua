local none_ls = require("none-ls")

local function get_python_executable()
    local virtual_env = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    return virtual_env .. "/bin/python3"
end

none_ls.setup({
    sources = {
        none_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
                return { "--python-executable", get_python_executable() }
            end,
        }),
        none_ls.builtins.diagnostics.eslint_d,
    },
})
