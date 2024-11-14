<div align="center">

# .dotfiles

</div>

<img src="./images/dotfiles.png" alt="Nvchad + terminal image (config applied)"/>

1. NvChad v3.0
2. WezTerm
3. Fish
4. Starship

## Table of Contents

- [Dependencies](#dependencies)
  - [Fonts](#fonts)
  - [NvChad](#for-nvchad-nvim)
  - [WezTerm](#wezterm)
  - [Fish and Starship](#fish-and-starship)
  - [Packages](#packages)
- [Install](#install)
- [All Plugins](#all-plugins-nvchad)
- [Acknowledgements](#Acknowledgements)

## Dependencies

### Fonts

You need these fonts for NvChad and WezTerm:

- [Install JetBrains Mono](https://github.com/JetBrains/JetBrainsMono#installation)
- [Install Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)

### For NvChad (nvim)

- [Install Neovim](https://github.com/neovim/neovim#install-from-package)
- [Install NvChad](https://nvchad.com/docs/quickstart/install)

### WezTerm

- [Install WezTerm](https://wezfurlong.org/wezterm/installation)

### Fish and Starship

- [Install Fish Shell](https://github.com/fish-shell/fish-shell#getting-fish)
- [Install Starship](https://github.com/starship/starship#-installation)

### Packages

- git
- go
- lazygit
- lua
- luarocks
- npm
- python
- rust

_Install these packages via your package manager, as they are required for some Neovim plugins and LSP servers_

## Install

To install all configurations, run the following commands:

```bash
git clone git@github.com:YaroslavTheOmen/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

Alternatively, you can manually copy the files you need:

1. NvChad: `.config/nvim`
2. WezTerm: `.wezterm.lua`
3. Fish: `.config/fish/config.fish`
4. Starship: `.config/starship.toml`

**Don't forget to update the necessary paths:**

- shell path, Python venv path, and base46 path in `.config/nvim/init.lua` (at the beginning)
- shell path in `.wezterm.lua`
- starship path and `$PATH` using `set -x PATH` in `.config/fish/config.fish`

If you encounter any issues or have questions, please feel free to open an issue on the project's GitHub repository.

## All Plugins NvChad

### 1. Lazy

- General:

  - [b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim)
  - [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
  - [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
  - [github/copilot.vim](https://github.com/github/copilot.vim)
  - [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
  - [mrcjkb/rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
  - [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
  - [nvchad/base46](https://github.com/NvChad/base46)
  - [nvchad/showkeys](https://github.com/nvzone/showkeys)
  - [nvchad/ui](https://github.com/NvChad/ui)
  - [nvzone/menu](https://github.com/nvzone/menu)
  - [nvzone/minty](https://github.com/nvzone/minty)
  - [nvzone/volt](https://github.com/nvzone/volt)
  - [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
  - [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)
  - [olexsmir/gopher.nvim](https://github.com/olexsmir/gopher.nvim)
  - [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
  - [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
  - [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm)
  - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  - [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
  - [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)

- Nvim-cmp:

  - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
  - [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
  - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
  - [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  - [onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim)
  - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
  - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

### 2. Mason

- Linters:

  - `luacheck`

- LSP Servers:

  - `clangd`
  - `css-lsp`
  - `gopls`
  - `html-lsp`
  - `lua-language-server`
  - `pyright`
  - `ruff`
  - `rust-analyzer`
  - `tailwindcss-language-server`
  - `typescript-language-server`

- Formatters:

  - `black`
  - `clang-format`
  - `gofumpt`
  - `prettierd`
  - `rustfmt`
  - `stylua`

- Analysis Tools:

  - `eslint_d`
  - `golangci-lint`
  - `luacheck`
  - `mypy`

## Acknowledgements

**Disclaimer**: I am not the creator of the plugins included in this configuration. All plugins are the work of their respective authors. Please review the licenses of each plugin before using or modifying them in your own projects.
