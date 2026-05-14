#!/bin/bash

set -e

echo "Setting up Neovim..."

# Install required packages
echo "Installing packages..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    brew install neovim git node go ripgrep fd tree-sitter
elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu
    sudo apt update
    sudo apt install -y neovim git nodejs golang-go ripgrep fd-find
elif [[ -f /etc/redhat-release ]]; then
    # RHEL/Fedora/CentOS
    sudo dnf install -y neovim git nodejs golang ripgrep fd-find
else
    echo "Unsupported OS. Please install manually: neovim git node go ripgrep fd"
fi

# Create config directory
mkdir -p ~/.config

# Backup existing nvim config/symlink and data directories
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -e ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak
[ -e ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak
[ -e ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak

# Create symlink
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Install Go language server
go install golang.org/x/tools/gopls@latest

# Install Python debugger
python3 -m pip install --user debugpy

# Install prettier for formatting
npm install -g prettier

echo "Neovim setup complete. Run 'nvim' to finish plugin installation."