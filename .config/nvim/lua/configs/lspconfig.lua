pcall(vim.loader.enable)

-- 1. UI / Diagnostics --------------------------------------------------
local border = "rounded"
--vim.lsp.ui.windows.default_options = { border = border }
--
local ok_ui, winmod = pcall(function()
    return vim.lsp.ui and vim.lsp.ui.windows
end)
if not ok_ui or not winmod then
    local ok_lspcfg, lspcfg_win = pcall(require, "lspconfig.ui.windows")
    if ok_lspcfg then
        winmod = lspcfg_win
    end
end
if winmod then
    winmod.default_options = { border = border }
else
    vim.notify("[LSP] Could not locate windows module to set border", vim.log.levels.WARN)
end

vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    signs = true,
    underline = { severity = vim.diagnostic.severity.HINT },
    virtual_lines = false,
    float = {
        border = border,
        header = "",
        scope = "line",
        focusable = false,
        severity_sort = true,
    },
    jump = { float = true },
})

vim.opt.winborder = border

-- 2. Capabilities (cmp-nvim-lsp) ---------------------------------------
local capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 3. on_attach ---------------------------------------------------------
local function custom_on_attach(client, bufnr)
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
    end, opts)
    map("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
    end, opts)

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

-- 4. Shared helpers ----------------------------------------------------
local schemastore = require("schemastore")

-- Convert a util.root_pattern list → root_markers
local function markers(...)
    return { ... }
end

-- 5. Per-server configurations ----------------------------------------
local cfg = vim.lsp.config -- shorthand

cfg["lua_ls"] = {
    cmd = { "lua-language-server" },
    on_attach = custom_on_attach,
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
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = true,
        },
    },
    root_markers = markers("package.json", ".git"),
}

cfg["yamlls"] = {
    cmd = { "yaml-language-server", "--stdio" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = schemastore.yaml.schemas(),
            validate = true,
            schemaStore = { enable = false, url = "" },
        },
    },
    root_markers = markers(".git"),
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
    on_attach = custom_on_attach,
    capabilities = capabilities,
    root_markers = markers("compile_commands.json", "compile_flags.txt", ".git"),
}

cfg["html"] = {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
        html = {
            format = { enable = true },
            hover = { documentation = true },
        },
    },
}

cfg["cssls"] = {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
    },
}

cfg["tailwindcss"] = { on_attach = custom_on_attach, capabilities = capabilities }
cfg["eslint"] = { on_attach = custom_on_attach, capabilities = capabilities }
cfg["ruff"] = { on_attach = custom_on_attach, capabilities = capabilities }

cfg["ts_ls"] = { on_attach = custom_on_attach, capabilities = capabilities }

cfg["pyright"] = {
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = custom_on_attach,
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
    on_attach = custom_on_attach,
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

cfg["sqls"] = {
    filetypes = { "sql" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    root_markers = markers(".git", "*.sql"),
}

cfg["solidity"] = {
    cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
    filetypes = { "solidity" },
    on_attach = custom_on_attach,
    capabilities = capabilities,

    root_markers = markers(
        "foundry.toml", -- Foundry
        "remappings.txt", -- Forge remappings
        "truffle-config.js", -- Truffle
        "hardhat.config.js", -- Hardhat
        ".git" -- fallback
    ),

    single_file_support = true,
}

cfg["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    init_options = { buildDirectory = "build" },
    root_markers = markers("CMakePresets.json", "CMakeLists.txt", ".git"),
}

cfg["dockerls"] = {
    filetypes = { "Dockerfile" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    root_markers = markers("Dockerfile", ".git"),
}

cfg["docker_compose_language_service"] = {
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml", "yml" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    root_markers = markers("docker-compose.yml", "docker-compose.yaml", ".git"),
}

cfg["marksman"] = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    on_attach = custom_on_attach,
    capabilities = capabilities,
    root_markers = markers(".git", ".marksman.toml", ".marksman.yaml"),
}

-- 6. Enable the servers ------------------------------------------------
vim.lsp.enable({
    "lua_ls",
    "jsonls",
    "yamlls",
    "clangd",
    "html",
    "cssls",
    "tailwindcss",
    "ts_ls",
    "eslint",
    "ruff",
    "pyright",
    "gopls",
    "sqls",
    "solidity",
    "cmake",
    "dockerls",
    "docker_compose_language_service",
    "marksman",
})

-- 7. Mason (optional – download binaries only) -------------------------
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "cmake",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff",
        -- "rust_analyzer",
        "solidity",
        "sqls",
        "tailwindcss",
        "ts_ls",
        "yamlls",
        "marksman",
    },
    handlers = {}, -- no auto-setup – we handle config above
    automatic_enable = {
        exclude = { "rust_analyzer" },
    },
})

-- 8. RustaceanVim ------------------------------------------------------
-- Defer rust-analyzer lifecycle to RustaceanVim. Shares on_attach/caps.
vim.g.rustaceanvim = {
    server = {
        on_attach = custom_on_attach,
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
