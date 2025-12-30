#!/bin/bash

# Setup Workspace CatchyOS - Main Installation Script
# Run this script to set up your development environment

set -e

echo "🚀 Starting CatchyOS Workspace Setup..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}❌ This script is designed for Arch Linux only!${NC}"
    exit 1
fi

# Function to print status
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Step 1: Install pacman packages
echo "📦 Installing pacman packages..."
if [ -f "packages/pacman-list.txt" ]; then
    sudo pacman -S --needed --noconfirm $(cat packages/pacman-list.txt | grep -v '^#' | tr '\n' ' ')
    print_status "Pacman packages installed"
else
    print_error "packages/pacman-list.txt not found!"
fi

# Step 2: Install AUR packages (requires yay)
echo ""
echo "📦 Installing AUR packages..."
if command -v yay &> /dev/null; then
    if [ -f "packages/aur-list.txt" ]; then
        yay -S --needed --noconfirm $(cat packages/aur-list.txt | grep -v '^#' | tr '\n' ' ')
        print_status "AUR packages installed"
    else
        print_error "packages/aur-list.txt not found!"
    fi
else
    print_warning "yay not found. Installing yay first..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd -
    if [ -f "packages/aur-list.txt" ]; then
        yay -S --needed --noconfirm $(cat packages/aur-list.txt | grep -v '^#' | tr '\n' ' ')
        print_status "AUR packages installed"
    fi
fi

# Step 3: Setup configurations
echo ""
echo "⚙️  Setting up configurations..."

# Backup existing configs
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
    print_status "Backed up existing .zshrc"
fi

if [ -f "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" "$BACKUP_DIR/.gitconfig"
    print_status "Backed up existing .gitconfig"
fi

# Copy configs
if [ -f "configs/.zshrc" ]; then
    cp configs/.zshrc "$HOME/.zshrc"
    print_status "Installed .zshrc"
fi

if [ -f "configs/.gitconfig" ]; then
    cp configs/.gitconfig "$HOME/.gitconfig"
    print_status "Installed .gitconfig"
fi

if [ -f "configs/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    cp configs/starship.toml "$HOME/.config/starship.toml"
    print_status "Installed starship.toml"
fi

if [ -f "configs/mise.toml" ]; then
    mkdir -p "$HOME/.config"
    cp configs/mise.toml "$HOME/.config/mise.toml"
    print_status "Installed mise.toml"
fi

# Copy aliases file
if [ -f "configs/aliases.zsh" ]; then
    cp configs/aliases.zsh "$HOME/.aliases.zsh"
    print_status "Installed aliases.zsh"
fi

# Step 4: Setup Docker stack
echo ""
echo "🐳 Setting up Docker stack..."
if [ -d "docker-stack" ]; then
    chmod +x docker-stack/control.sh
    print_status "Docker stack scripts ready"
fi

# Step 5: Run additional setup scripts
echo ""
echo "🔧 Running additional setup scripts..."

if [ -f "scripts/setup-android.sh" ]; then
    chmod +x scripts/setup-android.sh
    ./scripts/setup-android.sh
    print_status "Android setup completed"
fi

if [ -f "scripts/setup-ssh-vpn.sh" ]; then
    chmod +x scripts/setup-ssh-vpn.sh
    ./scripts/setup-ssh-vpn.sh
    print_status "SSH/VPN setup completed"
fi

if [ -f "scripts/setup-php-laravel.sh" ]; then
    chmod +x scripts/setup-php-laravel.sh
    ./scripts/setup-php-laravel.sh
    print_status "PHP Laravel setup completed"
fi

# Setup git clone script
if [ -f "scripts/git-clone-all.sh" ]; then
    chmod +x scripts/git-clone-all.sh
    print_status "Git clone script ready"
fi

echo ""
echo -e "${GREEN}✅ Setup completed successfully!${NC}"
echo ""
echo "📝 Next steps:"
echo "  1. Review and edit $HOME/.gitconfig with your user info"
echo "  2. Restart your terminal or run: source ~/.zshrc"
echo "  3. Use docker-stack/control.sh to manage services"
echo ""
echo "💾 Backups saved to: $BACKUP_DIR"

