local M = {}

M.base46 = {
    theme = "one_light", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = { "one_light", "catppuccin" },
}

M.ui = {
    cmp = {
        icons_left = false, -- only for non-atom styles!
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        abbr_maxwidth = 60,
        format_colors = {
            tailwind = true, -- will work for css lsp too
            icon = "󱓻",
        },
    },
    telescope = { style = "borderless" }, -- borderless / bordered
    statusline = {
        enabled = true,
        theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
        separator_style = "default",
        order = nil,
        modules = nil,
    },
    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "treeOffset", "buffers", "tabs", "btns" },
        modules = nil,
        bufwidth = 21,
    },
}

M.term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
        relative = "editor",
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
    },
}

M.lsp = { signature = true }

M.cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

M.colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
}

M.mason = {
    cmd = true,
    pkgs = {
        -- Language Servers
        "clangd",
        "cmake-language-server",
        "css-lsp",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gopls",
        "html-lsp",
        "lua-language-server",
        "pyright",
        "ruff",
        "rust-analyzer",
        "solidity",
        "sqls",
        "tailwindcss-language-server",
        "typescript-language-server",
        "marksman",

        -- Formatters
        "clang-format",
        "cmakelang",
        "gofumpt",
        "prettierd",
        "sql-formatter",
        "stylua",
        "yapf",

        -- Linters
        "eslint_d",
        "golangci-lint",
        "luacheck",
        "mypy",
        "solhint",
        "sqlfluff",
    },
}

return M
