-- Extra on-save linters that are NOT covered by none-ls
local lint = require "lint"

-- configure per-linter
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

-- map filetypes → linters
lint.linters_by_ft = {
  lua = { "luacheck" },
  go = { "golangci_lint" },
  solidity = { "solhint" },
  sql = { "sqlfluff" },
  -- js / ts diagnostics come from none-ls → eslint_d
}

-- auto-command: run after write
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
