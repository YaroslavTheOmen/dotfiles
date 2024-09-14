-- lua/configs/nvim-lint.lua

local luacheck = require "lint.linters.luacheck"

luacheck.args = {
  "--globals",
  "vim",
  "--std",
  "lua51",
  "--codes",
  "--no-color",
  "-",
}

require("lint").linters_by_ft = {
  python = { "mypy" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  lua = { "luacheck" },
  go = { "golangcilint" },
  -- c = { "clangtidy" },
  -- cpp = { "clangtidy" },
  -- Add more filetypes and linters as needed
}

-- Set up autocommand to run linter on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
