-- lua/configs/conform.lua

local conform = require("conform")

conform.setup({
   -- Configure formatters by filetype
   formatters_by_ft = {
      lua = { "stylua" },
      python = { "yapf" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      javascriptreact = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      go = { "gofumpt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      rust = { "rustfmt" },
      -- Add more filetypes and formatters as needed
   },

   -- Enable format on save
   format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 2000, -- Time in milliseconds to wait for a formatter to finish
      lsp_fallback = true, -- Use LSP formatting if no formatter is defined for a filetype
   },
})
