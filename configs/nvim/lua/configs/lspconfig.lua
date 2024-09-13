-- Import LSP configurations from NvChad
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Enable additional LSP capabilities supported by nvim-cmp
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Required imports
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- Common LSP on_attach function to enable keybindings and features across all languages
local function custom_on_attach(client, bufnr)
  -- Enable standard keybindings for LSP features
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  -- Autoformat on save if supported
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
      augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })
      augroup END
    ]]
  end
end

-- Update LSP configuration to include snippet support
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Python LSP setup with pyright and ruff_lsp
local servers_python = { "pyright", "ruff_lsp" }

for _, lsp in ipairs(servers_python) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  }
end

-- Web development LSP setup (TypeScript, Tailwind, etc.)
local servers_web = { "tsserver", "tailwindcss", "eslint" }

for _, lsp in ipairs(servers_web) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  }
end

-- Go LSP setup (gopls)
lspconfig.gopls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
    },
  },
}

-- HTML, CSS LSP setup (default configuration)
local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
  }
end

-- C++ LSP setup with clangd
lspconfig.clangd.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
}

-- Ensure schemastore is available
local schemastore = require "schemastore"

-- JSON setup with schema validation from schemastore
lspconfig.jsonls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
}

-- YAML setup with schema validation from schemastore
lspconfig.yamlls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = true,
    },
  },
}

-- rust
--lspconfig.rust_analyzer.setup {
--  on_attach = on_attach,
--  on_init = on_init,
--  capabilities = capabilities,
--  filetypes = { "rust" },
--  root_dir = util.root_pattern "Cargo.toml",
--  settings = {
--    ["rust_analyzer"] = {
--      Cargo = {
--        allFeatures = true,
--      },
--    },
--  },
--}
