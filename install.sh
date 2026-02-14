#!/usr/bin/env bash
set -e

# Install by using
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/joachimvenaas/zsh_configured/main/install.sh)"
#

# -------------------------------
# Backup existing configs
# -------------------------------
backup() {
  for file in .zshrc .p10k.zsh; do
    if [ -f ~/$file ]; then
      mv ~/$file ~/$file.bak
      echo "Backed up $file -> $file.bak"
    fi
  done
}

backup

# -------------------------------
# Copy configs
# -------------------------------
TMPDIR=$(mktemp -d)
curl -fsSL -o "$TMPDIR/zshrc" https://raw.githubusercontent.com/joachimvenaas/zsh_configured/main/zsh/zshrc
curl -fsSL -o "$TMPDIR/p10k.zsh" https://raw.githubusercontent.com/joachimvenaas/zsh_configured/main/zsh/p10k.zsh
cp "$TMPDIR/zshrc" ~/.zshrc
cp "$TMPDIR/p10k.zsh" ~/.p10k.zsh
rm -rf "$TMPDIR"

# Check if sudo exists, install if not
if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo not found, installing..."
  apt update && apt install -y sudo
fi

# -------------------------------
# Install dependencies
# -------------------------------
sudo apt update
sudo apt install -y zsh curl git unzip fontconfig gpg wget


# install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
  | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg

echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
  | sudo tee /etc/apt/sources.list.d/gierens.list

sudo apt update
sudo apt install -y eza

# -------------------------------
# Install Oh My Zsh
# -------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# -------------------------------
# Install Powerlevel10k theme
# -------------------------------
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "Powerlevel10k installed"
fi

# -------------------------------
# Install zsh-autosuggestions plugin
# -------------------------------
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo "zsh-autosuggestions installed"
fi

# -------------------------------
# Install zoxide
# -------------------------------
if ! command -v zoxide >/dev/null 2>&1; then
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# -------------------------------
# Set Zsh as default shell
# -------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

echo "Installation complete. Start a new terminal session or run 'zsh' to begin."
