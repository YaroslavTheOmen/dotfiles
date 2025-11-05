pcall(vim.loader.enable)

local ok, nls = pcall(require, "none-ls")
if not ok then
  vim.notify("none-ls.nvim not found!", vim.log.levels.ERROR)
  return
end

local extras = pcall(require, "none-ls-extras") and require("none-ls-extras") or nil

local function python_exec()
  local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX or "/usr"
  return venv .. "/bin/python3"
end

local sources = {
  nls.builtins.diagnostics.mypy.with({
    extra_args = function()
      return { "--python-executable", python_exec() }
    end,
  }),

  (extras and extras.diagnostics.eslint_d) or nls.builtins.diagnostics.eslint.with({
    command = "eslint_d",
  }),

  nls.builtins.diagnostics.credo.with({
    command = "mix",
    args = {
      "credo",
      "suggest",
      "--strict",
      "--format",
      "flycheck",
      "--read-from-stdin",
      "$FILENAME",
    },
  }),

  nls.builtins.diagnostics.solhint,

  nls.builtins.diagnostics.sqlfluff.with({
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

  nls.builtins.diagnostics.luacheck.with({
    extra_args = { "--globals", "vim", "--std", "lua51", "--codes", "--no-color", "-" },
  }),

  nls.builtins.diagnostics.golangci_lint,
}

nls.setup({
  sources = sources,
  diagnostics_format = "#{m} (#{s})",
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
