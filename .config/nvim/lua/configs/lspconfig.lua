local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local schemastore = require("schemastore")

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local function custom_on_attach(client, bufnr)
    -- Common options for all mappings
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    -- Hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Find references
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
    end, opts)

    -- Disable formatting via LSP to prevent conflicts with other formatters
    -- if client.server_capabilities.document_formatting then
    --    client.server_capabilities.document_formatting = false
    -- end
    -- if client.server_capabilities.document_range_formatting then
    --   client.server_capabilities.document_range_formatting = false
    -- end
end

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

    cmake = {
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = util.root_pattern("CMakePresets.json", "CMakeLists.txt", ".git"),
        init_options = {
            buildDirectory = "build",
        },
        single_file_support = true,
    },

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

    jsonls = {
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = { enable = true },
            },
        },
    },

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

    dockerls = {
        filetypes = { "Dockerfile" },
        root_dir = util.root_pattern("Dockerfile", ".git"),
    },

    docker_compose_language_service = {
        cmd = { "docker-compose-langserver", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_dir = util.root_pattern("docker-compose.yml", "docker-compose.yaml", ".git"),
        settings = {},
    },
}

require("mason-lspconfig").setup_handlers({
    ["rust_analyzer"] = function() end,

    function(server_name)
        local config = {
            on_attach = custom_on_attach,
            capabilities = capabilities,
        }

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
                checkOnSave = {
                    command = "clippy",
                },
                diagnostics = {
                    enable = true,
                    disabled = {},
                    enableExperimental = true,
                },
                cargo = {
                    features = "All",
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
                completion = {
                    addCallArgumentSnippets = true,
                    postfix = {
                        enable = true,
                    },
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
                experimental = {
                    procAttrMacros = true,
                },
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
            },
        },
    },
}
