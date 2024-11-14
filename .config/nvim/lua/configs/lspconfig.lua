-- Import necessary modules
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local schemastore = require("schemastore")

-- Initialize Mason and Mason-Lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = {
      "lua_ls",
      "pyright",
      "ruff",
      "rust_analyzer",
      "ts_ls",
      "tailwindcss",
      "eslint",
      "gopls",
      "clangd",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      -- Add other servers you want to ensure are installed
   },
})

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

   -- Disable formatting via LSP to prevent conflicts with other formatters
   if client.server_capabilities.document_formatting then
      client.server_capabilities.document_formatting = false
   end
   if client.server_capabilities.document_range_formatting then
      client.server_capabilities.document_range_formatting = false
   end
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
      cmd = { "pyright-langserver", "--stdio", "--offset-encoding=utf-16" },
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
   ruff = {},

   -- Web development LSP servers
   ts_ls = { -- Replaced from tsserver to ts_ls
      settings = {
         typescript = {
            inlayHints = {
               includeInlayParameterNameHints = "all",
               includeInlayParameterNameHintsWhenArgumentMatchesName = false,
               includeInlayFunctionParameterTypeHints = true,
               includeInlayVariableTypeHints = true,
            },
         },
         javascript = { -- Add JavaScript settings if needed
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
      cmd = {
         "clangd",
         "--background-index",
         "--clang-tidy",
         "--completion-style=detailed",
         "--offset-encoding=utf-16",
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      capabilities = capabilities,
   },

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

-- Setup LSP servers with mason-lspconfig
require("mason-lspconfig").setup_handlers({
   -- Handler for rust_analyzer to prevent double setup
   ["rust_analyzer"] = function()
      -- Do nothing; rustaceanvim will handle rust_analyzer
   end,

   -- Default handler for all servers
   function(server_name)
      local config = {
         on_attach = custom_on_attach,
         capabilities = capabilities,
      }

      -- Apply specific settings based on the server
      if servers[server_name] then
         config = vim.tbl_deep_extend("force", config, servers[server_name])
      end

      lspconfig[server_name].setup(config)
   end,
})

-- Rust setup using rustaceanvim

vim.g.rustaceanvim = {
   server = {
      on_attach = custom_on_attach,
      capabilities = capabilities,
      settings = {
         ["rust-analyzer"] = {
            -- Enable checking with Clippy on save for linting
            checkOnSave = {
               command = "clippy", -- Alternatives: "check" for faster checks without lints
            },

            -- Diagnostics settings
            diagnostics = {
               enable = true,
               disabled = {}, -- List any diagnostics you want to disable
               enableExperimental = true, -- Enable experimental diagnostics
            },

            -- Cargo settings
            cargo = {
               features = "All", -- Features to enable for Cargo.toml
               loadOutDirsFromCheck = true, -- Improves performance by caching build directories
            },

            -- Proc macro settings
            procMacro = {
               enable = true, -- Enables procedural macro support
            },

            -- Completion settings
            completion = {
               addCallArgumentSnippets = true, -- Adds snippets for function call arguments
               postfix = {
                  enable = true, -- Enables postfix completions (e.g., `.if`, `.match`)
               },
            },

            -- Hover settings
            hover = {
               actions = {
                  references = true, -- Show references in hover
                  implementation = true, -- Show implementations in hover
               },
            },

            -- Rustfmt settings for formatting
            rustfmt = {
               enableRangeFormatting = true, -- Enable formatting for selected ranges
               extraArgs = { "--edition", "2021" }, -- Additional arguments for rustfmt
            },

            -- Experimental features
            experimental = {
               procAttrMacros = true, -- Support for procedural attribute macros
            },

            -- Assist settings for code assistance
            assist = {
               importGranularity = "module", -- Import granularity (e.g., "module" or "crate")
               importPrefix = "by_self", -- Import prefix style
            },
         },
      },
   },
}
