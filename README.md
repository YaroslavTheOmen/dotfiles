<div align="center">

# .dotfiles

</div>

<img src="./images/dotfiles.png" alt="Nvchad + terminal image (config applied)"/>

1. NvChad v3.0
2. Doom
3. WezTerm
4. Fish
5. Starship

## Table of Contents

- [Dependencies](#dependencies)
  - [Fonts](#fonts)
  - [NvChad](#nvchad-nvim)
  - [Doom](#doom-emacs)
  - [WezTerm](#wezterm)
  - [Fish and Starship](#fish-and-starship)
  - [Packages](#packages)
- [Install](#install)
- [All Plugins](#all-plugins-nvchad)
- [Acknowledgements](#Acknowledgements)

## Dependencies

### Fonts

You need these fonts for NvChad, Doom and WezTerm:

- [Install JetBrains Mono](https://github.com/JetBrains/JetBrainsMono#installation)
- [Install Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)
- [Install Font Symbols Only Nerd Font](https://formulae.brew.sh/cask/font-symbols-only-nerd-font)

### NvChad (nvim)

- [Install Neovim](https://github.com/neovim/neovim#install-from-package)
- [Install NvChad](https://nvchad.com/docs/quickstart/install)

### Doom (emacs)

- [Install Doom](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

### WezTerm

- [Install WezTerm](https://wezfurlong.org/wezterm/installation)

### Fish and Starship

- [Install Fish Shell](https://github.com/fish-shell/fish-shell#getting-fish)
- [Install Starship](https://github.com/starship/starship#-installation)

### Packages

- coreutils
- fd
- git
- go
- foundry
- lazygit
- lua
- luarocks
- npm
- python
- rust
- ripgrep

_Install these packages via your package manager (or manually), as they are required for NvChad, Doom, plugins and LSP servers_

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
2. Doom: `.config/doom`
3. WezTerm: `.wezterm.lua`
4. Fish: `.config/fish/config.fish`
5. Starship: `.config/starship.toml`

**Don't forget to update the necessary paths:**

- shell path, Python venv path, and base46 path in `.config/nvim/init.lua` (at the beginning)
- shell path in `.config/doom/config.el` (at the end)
- shell path in `.wezterm.lua`
- starship path and `$PATH` using `set -x PATH` in `.config/fish/config.fish`
- `$VIMRUNTIME` using `set -gx` in `.config/fish/config.fish`

If you encounter any issues or have questions, please feel free to open an issue on the project's GitHub repository.

## All Plugins NvChad

Here’s the list updated to exactly match the plugins in your return { … } spec (adding the one you were missing):

### 1. Lazy

- General:

  - [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
  - [b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim)
  - [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
  - [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
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
  - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  - [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
  - [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
  - [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)

- Nvim-cmp:

  - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
  - [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
  - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
  - [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  - [onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim)
  - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
  - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)### 2. Mason

- Language Servers:

  - `clangd`
  - `cmake-language-server`
  - `css-lsp`
  - `docker-compose-language-service`
  - `dockerfile-language-server`
  - `gopls`
  - `html-lsp`
  - `jsonls`
  - `lua-language-server`
  - `pyright`
  - `ruff`
  - `rust-analyzer`
  - `solidity`
  - `sqls`
  - `tailwindcss-language-server`
  - `typescript-language-server`
  - `yamlls`
  - `marksman`

- Formatters:

  - `prettierd_ft`
  - `stylua`
  - `yapf`
  - `gofumpt`
  - `clang_format`
  - `rustfmt`
  - `sql_formatter`
  - `cmake_format`
  - `forge_fmt`

- Linters:

  - none

## Acknowledgements

**Disclaimer**: I am not the creator of the plugins included in this configuration. All plugins are the work of their respective authors. Please review the licenses of each plugin before using or modifying them in your own projects.
