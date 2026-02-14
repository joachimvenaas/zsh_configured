#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
cp $DOTFILES_DIR/zsh/zshrc ~/.zshrc
cp $DOTFILES_DIR/zsh/p10k.zsh ~/.p10k.zsh
echo "Configs copied"

# -------------------------------
# Install dependencies
# -------------------------------
sudo apt update
sudo apt install -y zsh curl git unzip fontconfig eza

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
