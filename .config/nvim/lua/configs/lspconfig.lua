require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local on_attach, capabilities = nvlsp.on_attach, nvlsp.capabilities

local schemastore = require "schemastore"

local function markers(...)
  return { ... }
end

local MASON = vim.fn.stdpath "data" .. "/mason/bin/"

local cfg = vim.lsp.config

cfg["lua_ls"] = {
  cmd = { "lua-language-server" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
  root_markers = markers(".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git"),
}

cfg["jsonls"] = {
  cmd = { "vscode-json-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
  root_markers = markers("package.json", ".git"),
}

cfg["yamlls"] = {
  cmd = { "yaml-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = true,
      schemaStore = { enable = false, url = "" },
    },
  },
  root_markers = markers ".git",
}

cfg["clangd"] = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--offset-encoding=utf-16",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = markers("compile_commands.json", "compile_flags.txt", ".git"),
}

cfg["html"] = {
  on_attach = on_attach,
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        },
      },
    },
  }),
  settings = {
    html = {
      format = { enable = true },
      hover = { documentation = true },
    },
  },
}

cfg["cssls"] = {
  on_attach = on_attach,
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        },
      },
    },
  }),
  settings = {
    css = { validate = true, lint = { unknownAtRules = "ignore" } },
    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
    less = { validate = true, lint = { unknownAtRules = "ignore" } },
  },
}

cfg["tailwindcss"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      experimental = {
        classRegex = {},
      },
    },
  },
}
cfg["eslint"] = { on_attach = on_attach, capabilities = capabilities }

cfg["ruff"] = { on_attach = on_attach, capabilities = capabilities }

cfg["ts_ls"] = { on_attach = on_attach, capabilities = capabilities }

cfg["pyright"] = {
  cmd = { "pyright-langserver", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
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

cfg["gopls"] = {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  on_attach = on_attach,
  capabilities = capabilities,
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

cfg["elixirls"] = {
  cmd = { MASON .. "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
  root_markers = markers("mix.exs", "mix.lock", ".git"),
}

cfg["solidity"] = {
  cmd = { MASON .. "solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  on_attach = on_attach,
  capabilities = capabilities,

  root_markers = markers("foundry.toml", "remappings.txt", "truffle-config.js", "hardhat.config.js", ".git"),

  single_file_support = true,
}

cfg["cmake"] = {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/cmake-language-server" },
  filetypes = { "cmake" },
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    buildDirectory = "build",
  },
  root_markers = markers("CMakePresets.json", "CMakeLists.txt", ".git"),
  single_file_support = false,
}

cfg["dockerls"] = {
  filetypes = { "Dockerfile" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = markers("Dockerfile", ".git"),
}

cfg["docker_compose_language_service"] = {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml", "yml" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = markers("docker-compose.yml", "docker-compose.yaml", ".git"),
}

cfg["marksman"] = {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = markers(".git", ".marksman.toml", ".marksman.yaml"),
}

local taplo_caps = vim.tbl_deep_extend("force", capabilities, {})
taplo_caps.textDocument.completion.completionItem.snippetSupport = false

cfg["taplo"] = {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  on_attach = on_attach,
  capabilities = taplo_caps,
  root_markers = markers(".taplo.toml", "Cargo.toml", ".git"),
  single_file_support = true,
}

local servers = {
  "lua_ls",
  "jsonls",
  "yamlls",
  "clangd",
  "html",
  "cssls",
  "tailwindcss",
  "ts_ls",
  "taplo",
  "elixirls",
  "eslint",
  "ruff",
  "pyright",
  "gopls",
  "solidity",
  "cmake",
  "dockerls",
  "docker_compose_language_service",
  "marksman",
}

vim.lsp.enable(servers)

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    default_settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = { command = "clippy" },
        diagnostics = {
          enable = true,
          enableExperimental = true,
        },
        cargo = {
          features = "all",
          loadOutDirsFromCheck = true,
        },
        procMacro = { enable = true },
        completion = {
          addCallArgumentSnippets = true,
          postfix = { enable = true },
        },
        hover = {
          actions = { references = true, implementation = true },
        },
        rustfmt = {
          enableRangeFormatting = true,
          extraArgs = { "--edition", "2021" },
        },
        experimental = { procAttrMacros = true },
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
      },
    },
  },
}

-- read :h vim.lsp.config for changing options of lsp servers
