
#!/usr/bin/env bash
set -e

echo "[dotfiles] Setting up environment..."

# 1. Install dependencies for building Neovim
echo "[dotfiles] Installing build dependencies..."
sudo apt update
sudo apt install -y \
  ninja-build gettext libtool libtool-bin autoconf automake cmake \
  g++ pkg-config unzip curl doxygen libncurses5-dev

# 2. Build and install Neovim v0.11.1 from source
if ! command -v nvim &>/dev/null || [[ "$(nvim --version | head -n1)" != *"v0.11.1"* ]]; then
  echo "[dotfiles] Building Neovim v0.11.1 from source..."
  git clone https://github.com/neovim/neovim.git
  cd neovim
  git checkout v0.11.1
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ..
  rm -rf neovim
else
  echo "[dotfiles] Neovim v0.11.1 already installed."
fi

# 3. Symlink Neovim config from correct Codespace path
echo "[dotfiles] Linking Neovim config from persisted path..."
mkdir -p ~/.config
ln -sfn /workspaces/.codespaces/.persistedshare/dotfiles/.config/nvim ~/.config/nvim

# 4. Apply bashrc
if [ -f ~/dotfiles/.bashrc ]; then
  echo "[dotfiles] Applying .bashrc..."
  cp ~/dotfiles/.bashrc ~/.bashrc
fi

echo "[dotfiles] Done!"

