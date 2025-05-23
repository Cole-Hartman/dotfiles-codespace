#!/usr/bin/env bash
set -e

echo "[dotfiles] Setting up environment..."

### 1. Install Neovim (v0.9.5)
if ! command -v nvim &>/dev/null || [[ "$(nvim --version | head -n1)" != *"v0.9.5"* ]]; then
  echo "[dotfiles] Installing Neovim v0.9.5..."
  curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
  tar xzf nvim-linux64.tar.gz
  sudo mv nvim-linux64 /opt/nvim
  sudo ln -sfn /opt/nvim/bin/nvim /usr/local/bin/nvim
  rm nvim-linux64.tar.gz
else
  echo "[dotfiles] Neovim already installed."
fi

### 2. Symlink Neovim config
echo "[dotfiles] Linking Neovim config..."
mkdir -p ~/.config
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim

echo "[dotfiles] Done!"

