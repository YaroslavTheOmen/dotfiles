local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local schemastore = require("schemastore")

-- Diagnostic LSP
local border = "rounded"
require("lspconfig.ui.windows").default_options = { border = border }
vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
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

-- A. nvim-cmp (default) ------------------------------------------------
local capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- B. Blink -------------------------------------------------------------
-- local capabilities = require("blink.cmp").get_lsp_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )

-- on_attach ------------------------------------------------------------
local function custom_on_attach(client, bufnr)
    local map_opts = { noremap = true, silent = true }
    local map = vim.api.nvim_buf_set_keymap

    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", map_opts)
    map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", map_opts)
    map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", map_opts)
    map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", map_opts)
    map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", map_opts)
    map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", map_opts)
    map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", map_opts)
    map(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", map_opts)
    map(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", map_opts)

    -- disable server-side formatting
    if client.server_capabilities.documentFormattingProvider ~= nil then
        client.server_capabilities.documentFormattingProvider = false
    end
    if client.server_capabilities.documentRangeFormattingProvider ~= nil then
        client.server_capabilities.documentRangeFormattingProvider = false
    end
    -- ≤ 0.9 compatibility
    if client.server_capabilities.document_formatting ~= nil then
        client.server_capabilities.document_formatting = false
    end
    if client.server_capabilities.document_range_formatting ~= nil then
        client.server_capabilities.document_range_formatting = false
    end
end

-- Lua ------------------------------------------------------------------
lspconfig.lua_ls.setup({
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
})

-- Per-server overrides -------------------------------------------------
local servers = {
    sqls = {
        filetypes = { "sql" },
        root_dir = util.root_pattern(".git", "*.sql"),
    },

    solidity = {
        cmd = { "solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = util.root_pattern("truffle-config.js", "hardhat.config.js", ".git"),
    },

    cmake = {
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = util.root_pattern("CMakePresets.json", "CMakeLists.txt", ".git"),
        init_options = { buildDirectory = "build" },
    },

    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
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

    ts_ls = {},
    tailwindcss = {},
    eslint = {},
    ruff = {},

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

    html = {
        settings = {
            html = {
                format = { enable = true },
                hover = { documentation = true },
            },
        },
    },

    cssls = {
        settings = {
            css = { validate = true, lint = { unknownAtRules = "ignore" } },
            scss = { validate = true, lint = { unknownAtRules = "ignore" } },
            less = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
    },

    jsonls = {
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = true,
            },
        },
    },

    yamlls = {
        settings = {
            yaml = {
                schemas = schemastore.yaml.schemas(),
                validate = true,
                schemaStore = { enable = false, url = "" },
            },
        },
    },

    dockerls = {
        filetypes = { "Dockerfile" },
        root_dir = util.root_pattern("Dockerfile", ".git"),
    },

    docker_compose_language_service = {
        cmd = { "docker-compose-langserver", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_dir = util.root_pattern("docker-compose.yml", "docker-compose.yaml", ".git"),
    },
}

-- Mason ----------------------------------------------------------------
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
        --"lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "solidity",
        "sqls",
        "tailwindcss",
        "ts_ls",
        "yamlls",
    },

    handlers = {
        ["rust_analyzer"] = function() end,
        ["lua_ls"] = function() end,

        function(server)
            local opts = {
                on_attach = custom_on_attach,
                capabilities = capabilities,
            }

            if servers[server] then
                opts = vim.tbl_deep_extend("force", opts, servers[server])
            end

            lspconfig[server].setup(opts)
        end,
    },
})

-- RustaceanVim ---------------------------------------------------------
vim.g.rustaceanvim = {
    server = {
        on_attach = custom_on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = { command = "clippy" },
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
                    actions = {
                        references = true,
                        implementation = true,
                    },
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
