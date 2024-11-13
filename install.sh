#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        local timestamp=$(date +%Y%m%d%H%M%S)
        local backup="${target}.bak_${timestamp}"
        echo "Backing up existing $target to $backup"
        mv "$target" "$backup"
    fi
}

install_dir() {
    local source_dir="$1"
    local target_dir="$2"
    backup_if_exists "$target_dir"
    echo "Installing $source_dir to $target_dir"
    cp -r "$source_dir" "$target_dir"
}

install_file() {
    local source_file="$1"
    local target_file="$2"
    backup_if_exists "$target_file"
    echo "Installing $source_file to $target_file"
    cp "$source_file" "$target_file"
}

mkdir -p "$HOME/.config"

install_dir "$BASE_DIR/.config/nvim" "$HOME/.config/nvim"

mkdir -p "$HOME/.config/fish"
install_file "$BASE_DIR/.config/fish/config.fish" "$HOME/.config/fish/config.fish"

install_file "$BASE_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

install_file "$BASE_DIR/.wezterm.lua" "$HOME/.wezterm.lua"

echo "All configurations have been installed successfully."
