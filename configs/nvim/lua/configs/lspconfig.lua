-- Import necessary modules
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local schemastore = require "schemastore"

-- Define capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Custom on_attach function to set keybindings
local function custom_on_attach(client, bufnr)
  -- Set up keybindings
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  -- Remove autoformatting on save from on_attach to avoid conflicts
  -- as conform's format_on_save handles formatting
end

-- Configure LSP servers
local servers = {
  -- Lua LSP server
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },

  -- Python LSP servers
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  ruff_lsp = {},

  -- Web development LSP servers
  ts_ls = {
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
  },
  tailwindcss = {},
  eslint = {},

  -- Go LSP server
  gopls = {
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
  },

  -- C/C++ LSP server
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    capabilities = capabilities,
  },

  -- Add ccls configuration
  --ccls = {
  --  cmd = { "ccls" },
  --  filetypes = { "c", "cpp", "objc", "objcpp" },
  --  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  --  capabilities = capabilities,
  --  init_options = {
  --    compilationDatabaseDirectory = "build",
  --    index = {
  --      threads = 0,
  --    },
  --    clang = {
  --      excludeArgs = { "-frounding-math" },
  --    },
  --  },
  --},

  -- HTML LSP server
  html = {
    capabilities = vim.tbl_extend("keep", capabilities, {
      documentFormatting = false,
    }),
    settings = {
      html = {
        format = {
          enable = true,
        },
        hover = {
          documentation = true,
          references = true,
        },
      },
    },
  },

  -- CSS LSP server
  cssls = {
    capabilities = vim.tbl_extend("keep", capabilities, {
      documentFormatting = false,
    }),
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },

  -- JSON LSP server with schemastore
  jsonls = {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    },
  },

  -- YAML LSP server with schemastore
  yamlls = {
    settings = {
      yaml = {
        schemas = schemastore.yaml.schemas(),
        validate = true,
        schemaStore = {
          enable = false,
          url = "",
        },
      },
    },
  },
}

-- Setup LSP servers with configurations
for server_name, config in pairs(servers) do
  config.on_attach = custom_on_attach
  config.capabilities = capabilities
  lspconfig[server_name].setup(config)
end

-- Rust setup using rustaceanvim
vim.g.rustaceanvim = {
  server = {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy", -- or "check"
        },
        diagnostics = {
          enable = true,
        },
      },
    },
  },
}
