<div align="center">

# .dotfiles

</div>

*macOS / Ubuntu*

1. NvChad
2. Doom
3. WezTerm
4. Fish
5. Starship

- [Dependencies](#dependencies)
  - [Fonts](#fonts)
  - [NvChad](#nvchad)
  - [Doom](#doom)
  - [WezTerm](#wezterm)
  - [Fish and Starship](#fish-and-starship)
  - [Packages, LSP Servers, and Formatters](#packages-lsp-servers-and-formatters)
- [Install](#install)

## Dependencies

### Fonts

You need these fonts for NvChad, Doom, and WezTerm:

- [Install JetBrains Mono](https://github.com/JetBrains/JetBrainsMono#installation)
- [Install Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)
- [Install Font Symbols Only Nerd Font](https://formulae.brew.sh/cask/font-symbols-only-nerd-font)

### NvChad

- [Install Neovim](https://github.com/neovim/neovim#install-from-package)
- [Install NvChad](https://nvchad.com/docs/quickstart/install)

### Doom

- [Install Emacs (Linux)](https://www.gnu.org/software/emacs/)
- [Install Emacs (macOS)](https://github.com/d12frosted/homebrew-emacs-plus)
- [Install Doom](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

### WezTerm

- [Install WezTerm](https://wezfurlong.org/wezterm/installation)

### Fish and Starship

- [Install Fish Shell](https://github.com/fish-shell/fish-shell#getting-fish)
- [Install Starship](https://github.com/starship/starship#-installation)

### Packages, LSP Servers, and Formatters

_Install these packages, LSP servers, and formatters; they’re required for NvChad, Doom Emacs, and related plugins._

**Packages:**

- `coreutils` (macOS)
- `fd`
- `git`
- `go`
- `foundry`
- `lazygit`
- `lua`
- `luarocks`
- `npm`
- `python`
- `rust`
- `ripgrep`
- `fisher`
- `bass` (fisher)
- `nvm` (fisher)

**LSP Servers (Doom Emacs):**

- `pyright`
- `clangd`
- `elixir-ls`
- `gopls`
- `vscode-json-language-server`
- `typescript-language-server`
- `rust-analyzer`
- `bash-language-server`
- `vscode-html-language-server`
- `vscode-css-language-server`
- `yaml-language-server`
- `dockerfile-language-server-nodejs`
- `qmlls`

**Formatters (Doom Emacs):**

- `clang-format`
- `mix`
- `gofmt`
- `prettier`
- `rustfmt`
- `shfmt`
- `stylua`
- `ruff`
- `qmlformat`
- `forge`

## Install

Manually copy the files you need:

1. NvChad: `.config/nvim`
2. Doom: `.config/doom`
3. WezTerm: `.wezterm.lua`
4. Fish: `.config/fish/config.fish`
5. Starship: `.config/starship.toml`

**Don’t forget to update the necessary paths:**

- Shell path and Python venv path in `.config/nvim/init.lua`
- Shell path in `.config/doom/config.el`
- Shell path in `.wezterm.lua`
- Starship path and `$PATH` (using `set -x PATH`) in `.config/fish/config.fish`
