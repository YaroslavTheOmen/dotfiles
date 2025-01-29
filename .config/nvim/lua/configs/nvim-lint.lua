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

-- 2. Define linters for filetypes
-- Some filetypes share the same linter (e.g., "eslint_d")
local eslint_filetypes = { "javascript", "typescript" }

local linters_by_ft = {
   python = { "mypy" },
   lua = { "luacheck" },
   go = { "golangcilint" },
   -- c   = { "clangtidy" },
   -- cpp = { "clangtidy" },
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
