<div align="center">

# .dotfiles

</div>

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
  - [Packages and LSP Servers](#packages-and-lsp-servers)
- [Install](#install)

## Dependencies

### Fonts

You need these fonts for NvChad, Doom and WezTerm:

- [Install JetBrains Mono](https://github.com/JetBrains/JetBrainsMono#installation)
- [Install Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)
- [Install Font Symbols Only Nerd Font](https://formulae.brew.sh/cask/font-symbols-only-nerd-font)

### NvChad

- [Install Neovim](https://github.com/neovim/neovim#install-from-package)
- [Install NvChad](https://nvchad.com/docs/quickstart/install)

### Doom

- [Install Emacs (linux)](https://www.gnu.org/software/emacs/)
- [Install Emacs (macOS)](https://github.com/d12frosted/homebrew-emacs-plus)
- [Install Doom](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

### WezTerm

- [Install WezTerm](https://wezfurlong.org/wezterm/installation)

### Fish and Starship

- [Install Fish Shell](https://github.com/fish-shell/fish-shell#getting-fish)
- [Install Starship](https://github.com/starship/starship#-installation)

### Packages and LSP Servers

_Install these packages and LSP servers; they’re required for NvChad, Doom Emacs, and related plugins._

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

**LSP Servers (Doom Emacs):**

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

## Install

Manually copy the files you need:

1. NvChad: `.config/nvim`
2. Doom: `.config/doom`
3. WezTerm: `.wezterm.lua`
4. Fish: `.config/fish/config.fish`
5. Starship: `.config/starship.toml`

**Don't forget to update the necessary paths:**

- shell path and python venv path in `.config/nvim/init.lua`
- shell path in `.config/doom/config.el`
- shell path in `.wezterm.lua`
- starship path and `$PATH` using `set -x PATH` in `.config/fish/config.fish`
