local M = {}

M.base46 = {
   theme = "one_light",
   transparency = false,
   theme_toggle = { "one_light", "catppuccin" },
   hl_add = {},
   hl_override = {},
   integrations = {},
   changed_themes = {},
}

M.ui = {
   cmp = {
      icons_left = false,
      lspkind_text = true,
      style = "default",
      format_colors = {
         tailwind = true,
         icon = "󱓻",
      },
   },
   telescope = { style = "borderless" },
   statusline = {
      theme = "vscode_colored",
      separator_style = "default",
      order = nil,
      modules = nil,
   },
   tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
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
   theme = "grid",
   excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

M.mason = {
   cmd = true,
   pkgs = {
      -- List of packages to install
      -- extra
      "luacheck",

      -- Language Servers
      "lua-language-server",
      "html-lsp",
      "css-lsp",
      "typescript-language-server",
      "tailwindcss-language-server",
      "pyright",
      "ruff",
      "rust-analyzer",
      "gopls",
      "clangd",

      -- Formatters
      "stylua",
      "prettierd",
      "clang-format",
      "yapf", --"black",
      "gofumpt",
      "rustfmt",

      -- Linters
      "mypy",
      "eslint_d",
      "luacheck",
      "golangci-lint",
   },
}

M.colorify = {
   enabled = true,
   mode = "virtual",
   virt_text = "󱓻 ",
   highlight = { hex = true, lspvars = true },
}

return M
