-- Import necessary modules
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local schemastore = require("schemastore")

-- Initialize Mason and Mason-Lspconfig
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
        "rust_analyzer",
        "solidity",
        "sqls",
        "tailwindcss",
        "ts_ls",
        "yamlls",
    },
})

-- Define capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Custom on_attach function to set keybindings and disable LSP formatting
local function custom_on_attach(client, bufnr)
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

-- LSP server-specific settings
local servers = {

    sqls = {
        filetypes = { "sql" },
        root_dir = util.root_pattern(".git"),
        single_file_support = true,
        -- If you have advanced settings, you can configure them below:
        -- settings = {
        --   sqls = {
        --     connections = {
        --       {
        --         driver = 'mysql',
        --         dataSourceName = 'root:root@tcp(127.0.0.1:3306)/test',
        --       },
        --       -- More connections here...
        --     },
        --   },
        -- },
    },

    solidity = {
        cmd = { "solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = util.root_pattern("truffle-config.js", "hardhat.config.js", ".git"),
        settings = {
            solidity = {
                -- Optionally, include solidity-specific settings here.
                -- For example, you could specify a compiler version or remappings if needed.
            },
        },
    },

    -- cmake LSP server
    cmake = {
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = util.root_pattern("CMakePresets.json", "CMakeLists.txt", ".git"),
        init_options = {
            -- Adjust if you have a specific build directory
            buildDirectory = "build",
        },
        single_file_support = true,
    },

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
            javascript = {
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

    -- Docker-related LSPs
    -- Dockerfile language server
    dockerls = {
        filetypes = { "Dockerfile" },
        root_dir = util.root_pattern("Dockerfile", ".git"),
    },

    -- Docker Compose language server (custom setup, since it's not standard in nvim-lspconfig)
    docker_compose_language_service = {
        -- Usually the npm package is: docker-compose-language-service
        -- The binary is often named: docker-compose-langserver
        cmd = { "docker-compose-langserver", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_dir = util.root_pattern("docker-compose.yml", "docker-compose.yaml", ".git"),
        settings = {},
    },
}

-- Setup LSP servers with mason-lspconfig
require("mason-lspconfig").setup_handlers({
    -- Handler for rust_analyzer to prevent double setup
    ["rust_analyzer"] = function()
        -- Do nothing; rustaceanvim will handle rust_analyzer
    end,

    -- Default handler for all other servers
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

vim.g.rustaceanvim = {
    server = {
        on_attach = custom_on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                -- instead of a table here, this is just on/off
                checkOnSave = true,
                -- move your “clippy” override into `check`
                check = {
                    command = "clippy",
                },

                diagnostics = {
                    enable = true,
                    disabled = {},
                    enableExperimental = true,
                },

                cargo = {
                    -- lowercase "all", or an array of feature-names
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
