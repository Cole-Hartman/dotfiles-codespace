
#!/usr/bin/env bash
set -e

sudo apt update

# Dependencies for building Neovim
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen libncurses5-dev

# Build and install Neovim v0.11.1 from source
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout v0.11.1
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim

# Symlink Neovim config from correct Codespace path
mkdir -p ~/.config
ln -sfn /workspaces/.codespaces/.persistedshare/dotfiles/.config/nvim ~/.config/nvim

# Move bashrc
cp /workspaces/.codespaces/.persistedshare/dotfiles/.bashrc ~/.bashrc

# Tmux
sudo apt install -y tmux
cp /workspaces/.codespaces/.persistedshare/dotfiles/.tmux.conf ~/.tmux.conf

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Temporarily start a detached tmux session to install plugins
tmux new-session -d -s temp_plugin_install_session
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t temp_plugin_install_session

# # oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash
cp -r /workspaces/.codespaces/.persistedshare/dotfiles/.customposhthemes ~/.customposhthemes

source ~/.bashrc
bash -i

