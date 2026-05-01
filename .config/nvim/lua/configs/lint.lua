local lint = require "lint"

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  vue = { "eslint_d" },
  lua = { "luacheck" },
  python = { "ruff" },
  solidity = { "solhint" },
  sol = { "solhint" },
}

do
  local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
  if venv and lint.linters.mypy then
    lint.linters.mypy.cmd = venv .. "/bin/mypy"
  end
end

local aug = vim.api.nvim_create_augroup("NvimLint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  group = aug,
  callback = function()
    lint.try_lint()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = aug,
  callback = function()
    lint.try_lint()
    local ft = vim.bo.filetype
    if ft == "python" then
      lint.try_lint "mypy"
    elseif ft == "go" then
      lint.try_lint "golangcilint"
    elseif ft == "sql" or ft == "mysql" or ft == "plsql" or ft:match "sql" then
      lint.try_lint "sqlfluff"
    end
  end,
})

vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Lint current file" })
