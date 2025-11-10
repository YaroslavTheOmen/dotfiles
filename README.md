<div align="center">

# .dotfiles

</div>

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
6. You need to create `.config/sqls/config.yml` in order to connect to the database for the sqls LSP

**Don't forget to update the necessary paths:**

- shell path, Python venv path, and base46 path in `.config/nvim/init.lua` (at the beginning)
- shell path in `.config/doom/config.el` (at the end)
- shell path in `.wezterm.lua`
- starship path and `$PATH` using `set -x PATH` in `.config/fish/config.fish`
