-- none-ls setup for additional linters and formatters
local none_ls = require("none-ls")

-- 1. Helper: Get Python Executable Path
local function get_python_executable()
   -- Check for VIRTUAL_ENV or CONDA_PREFIX; otherwise default to /usr
   local virtual_env = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
   return virtual_env .. "/bin/python3"
end

-- 2. none-ls Setup
none_ls.setup({
   -- Replace with your own on_attach logic, if needed
   -- on_attach = custom_on_attach,

   sources = {
      -- Diagnostics (linters)
      none_ls.builtins.diagnostics.mypy.with({
         extra_args = function()
            return { "--python-executable", get_python_executable() }
         end,
      }), -- Python

      none_ls.builtins.diagnostics.eslint_d, -- JavaScript, TypeScript

      -- Additional linters/formatters go here...
      -- e.g., none_ls.builtins.formatting.black,
      --       none_ls.builtins.diagnostics.flake8,
      --       none_ls.builtins.formatting.prettier,
   },
})
