# dotfiles

*macOS / Ubuntu*

1. Doom Emacs
2. NvChad
3. WezTerm
4. Fish shell
5. Starship

- [Dependencies](#dependencies)
  - [Fonts](#fonts)
  - [Doom Emacs](#doom-emacs)
  - [NvChad](#nvchad)
  - [WezTerm](#wezterm)
  - [Fish shell and Starship](#fish-shell-and-starship)
  - [Packages, LSP Servers, and Formatters](#packages-lsp-servers-and-formatters)
- [Install](#install)
- [License](#license)

## Dependencies

### Fonts

You need these fonts for Doom Emacs, NvChad, and WezTerm:

- [Install JetBrains Mono](https://github.com/JetBrains/JetBrainsMono#installation)
- [Install Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)
- [Install Font Symbols Only Nerd Font](https://formulae.brew.sh/cask/font-symbols-only-nerd-font)

### Doom Emacs

- [Install Emacs (Linux)](https://www.gnu.org/software/emacs/)
- [Install Emacs (macOS)](https://github.com/d12frosted/homebrew-emacs-plus)
- [Install Doom](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

### NvChad

- [Install Neovim](https://github.com/neovim/neovim#install-from-package)
- [Install NvChad](https://nvchad.com/docs/quickstart/install)

### WezTerm

- [Install WezTerm](https://wezfurlong.org/wezterm/installation)

### Fish shell and Starship

- [Install Fish shell](https://github.com/fish-shell/fish-shell#getting-fish)
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

1. Doom Emacs: `.config/doom`
2. NvChad: `.config/nvim`
3. WezTerm: `.wezterm.lua`
4. Fish shell: `.config/fish/config.fish`
5. Starship: `.config/starship.toml`

**Don’t forget to update these paths for your system:**

- Shell path and Python virtual environment path in `.config/nvim/init.lua`
- Shell path in `.config/doom/config.el`
- Shell path in `.wezterm.lua`
- Starship path, `EDITOR`/`VISUAL`, and `$PATH` via `set -x PATH` in `.config/fish/config.fish`

## License

This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for details.
