-- Required imports from NvChad configuration
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Rust inlay hints and other settings
vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      -- Call the default NvChad on_attach function for standard features
      on_attach(client, bufnr)

      -- Enable Rust-specific keybindings and features
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)

      -- Enable formatting on save
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd [[
          augroup LspAutocommands
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })
          augroup END
        ]]
      end

      -- Additional Rust keybindings
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rr", ":RustRun<CR>", opts) -- Run Rust code
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rt", ":RustTest<CR>", opts) -- Run Rust tests
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rc", ":RustReloadWorkspace<CR>", opts) -- Reload workspace
    end,

    -- Enable inlay hints and other Rust Analyzer features
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy", -- Use `clippy` for more thorough checks
        },
        cargo = {
          allFeatures = true, -- Enable all cargo features
        },
        procMacro = {
          enable = true, -- Enable procedural macros
        },
        inlayHints = {
          enable = true, -- Enable inlay hints
          typeHints = {
            enable = true, -- Type hints inline
          },
          parameterHints = {
            enable = true, -- Parameter hints inline
          },
        },
      },
    },

    capabilities = capabilities,
  },
}
