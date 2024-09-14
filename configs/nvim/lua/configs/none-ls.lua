-- lua/configs/none-ls.lua

-- none-ls setup for additional linters and formatters
local none_ls = require("none-ls")

none_ls.setup({
  on_attach = custom_on_attach,
  sources = {
    -- Diagnostics (linters)
    none_ls.builtins.diagnostics.mypy.with({
      extra_args = function()
        local virtual_env = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        return { "--python-executable", virtual_env .. "/bin/python3" }
      end,
    }),                                    -- Python
    none_ls.builtins.diagnostics.eslint_d, -- JavaScript, TypeScript

    -- Additional linters can be added here
  },
})
