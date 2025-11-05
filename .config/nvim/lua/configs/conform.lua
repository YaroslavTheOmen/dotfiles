pcall(vim.loader.enable)

vim.api.nvim_create_autocmd("FileType", {
  desc = "4 spaces by default; Lua = 2; Makefiles use tabs",
  pattern = "*",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if ft == "make" then
      vim.opt_local.expandtab = false
      vim.opt_local.tabstop = 8
      vim.opt_local.shiftwidth = 8
      vim.opt_local.softtabstop = 0
    elseif ft == "lua" then
      vim.opt_local.expandtab = true
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
    else
      vim.opt_local.expandtab = true
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
    end
  end,
})

local ok, conform = pcall(require, "conform")
if not ok then
  vim.notify("conform.nvim not found!", vim.log.levels.ERROR)
  return
end

local prettierd_ft = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "html",
  "css",
  "scss",
  "json",
  "yaml",
  "markdown",
}

local formatters_by_ft = {
  elixir = { "mix" },
  heex = { "mix" },
  surface = { "mix" },
  lua = { "stylua" },
  python = { "yapf" },
  go = { "gofumpt" },
  c = { "clang_format" },
  cpp = { "clang_format" },
  rust = { "rustfmt" },
  sql = { "sql_formatter" },
  cmake = { "cmake_format" },
  solidity = { "forge_fmt" },
  toml = { "taplo" },
}
for _, ft in ipairs(prettierd_ft) do
  formatters_by_ft[ft] = { "prettierd" }
end

conform.setup({
  formatters_by_ft = formatters_by_ft,

  format_on_save = function(bufnr)
    local ok_stat, stat = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok_stat and stat and stat.size > 512 * 1024 then
      return
    end
    return { timeout_ms = 1000, lsp_fallback = false }
  end,

  formatters = {
    prettierd = (function()
      local path = vim.fn.expand("~/.config/nvim/.prettierrc.json")
      local okf = vim.fn.filereadable(path) == 1
      local content = okf and table.concat(vim.fn.readfile(path), "\n") or ""
      return { env = { PRETTIERD_DEFAULT_CONFIG = content } }
    end)(),

    clang_format = {
      prepend_args = function(ctx)
        local has_cfg = vim.fs.find(
          { ".clang-format", "_clang-format" },
          { upward = true, path = ctx.dirname }
        )[1]
        if has_cfg then
          return { "--style", "file" }
        else
          return {
            "--style",
            "{BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
          }
        end
      end,
    },
  },
})

vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ timeout_ms = 1000, lsp_fallback = false })
end, {})
