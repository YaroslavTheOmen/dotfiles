pcall(vim.loader.enable)

local ok, lint = pcall(require, "lint")
if not ok then
  vim.notify("nvim-lint not found!", vim.log.levels.ERROR)
  return
end

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

lint.linters_by_ft = {
  --lua = { "luacheck" },
  --go = { "golangci_lint" },
  --solidity = { "solhint" },
  --sql = { "sqlfluff" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
