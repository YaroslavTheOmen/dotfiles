-- 1. Require and configure 'nvim-lint' modules
local lint = require("lint")

-- Configure luacheck
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

-- Configure sqlfluff (optional: you can tweak args/dialect)
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

-- 2. Define linters for filetypes
-- share same linter
local eslint_filetypes = { "javascript", "typescript" }

local linters_by_ft = {
   python = { "mypy" },
   lua = { "luacheck" },
   go = { "golangcilint" },
   solidity = { "solhint" },
   -- c   = { "clangtidy" },
   -- cpp = { "clangtidy" },
   sql = { "sqlfluff" },
}

-- Assign 'eslint_d' to each filetype in eslint_filetypes
for _, ft in ipairs(eslint_filetypes) do
   linters_by_ft[ft] = { "eslint_d" }
end

-- Finally set it on nvim-lint
lint.linters_by_ft = linters_by_ft

-- 3. Run lint on save
vim.api.nvim_create_autocmd("BufWritePost", {
   callback = function()
      lint.try_lint()
   end,
})
