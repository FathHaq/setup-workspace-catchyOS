#!/bin/bash

# SSH and VPN Setup Script
# Creates necessary folders and sets up SSH/VPN tools

set -e

echo "🔐 Setting up SSH and VPN tools..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Create SSH directory structure
SSH_DIR="$HOME/.ssh"
echo "Creating SSH directory structure..."

if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    echo -e "${GREEN}✓ Created $SSH_DIR${NC}"
else
    echo -e "${GREEN}✓ $SSH_DIR already exists${NC}"
fi

# Create SSH config file if it doesn't exist
SSH_CONFIG="$SSH_DIR/config"
if [ ! -f "$SSH_CONFIG" ]; then
    cat > "$SSH_CONFIG" << 'EOF'
# SSH Configuration
# Add your SSH host configurations here

# Example:
# Host myserver
#     HostName example.com
#     User username
#     Port 22
#     IdentityFile ~/.ssh/id_rsa
#     ServerAliveInterval 60
#     ServerAliveCountMax 3

# Host github.com
#     HostName github.com
#     User git
#     IdentityFile ~/.ssh/id_github
#     IdentitiesOnly yes
EOF
    chmod 600 "$SSH_CONFIG"
    echo -e "${GREEN}✓ Created SSH config file${NC}"
else
    echo -e "${GREEN}✓ SSH config file already exists${NC}"
fi

# Create authorized_keys file if it doesn't exist
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"
if [ ! -f "$AUTHORIZED_KEYS" ]; then
    touch "$AUTHORIZED_KEYS"
    chmod 600 "$AUTHORIZED_KEYS"
    echo -e "${GREEN}✓ Created authorized_keys file${NC}"
else
    echo -e "${GREEN}✓ authorized_keys file already exists${NC}"
fi

# Generate SSH key if it doesn't exist
if [ ! -f "$SSH_DIR/id_rsa" ] && [ ! -f "$SSH_DIR/id_ed25519" ]; then
    echo ""
    echo -e "${BLUE}No SSH key found. Would you like to generate one? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Generating SSH key (Ed25519)..."
        ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)" -f "$SSH_DIR/id_ed25519" -N ""
        echo -e "${GREEN}✓ SSH key generated${NC}"
        echo ""
        echo "Your public key:"
        cat "$SSH_DIR/id_ed25519.pub"
        echo ""
    fi
else
    echo -e "${GREEN}✓ SSH key already exists${NC}"
fi

# Create VPN directory
VPN_DIR="$HOME/.vpn"
echo ""
echo "Creating VPN directory structure..."

if [ ! -d "$VPN_DIR" ]; then
    mkdir -p "$VPN_DIR"
    chmod 700 "$VPN_DIR"
    echo -e "${GREEN}✓ Created $VPN_DIR${NC}"
    
    # Create subdirectories
    mkdir -p "$VPN_DIR/configs"
    mkdir -p "$VPN_DIR/certs"
    mkdir -p "$VPN_DIR/scripts"
    
    # Create README
    cat > "$VPN_DIR/README.md" << 'EOF'
# VPN Configuration Directory

This directory contains VPN configurations and certificates.

## Structure
- `configs/` - VPN configuration files (.ovpn, .conf, etc.)
- `certs/` - Certificate files (.crt, .key, .pem, etc.)
- `scripts/` - VPN connection scripts

## Security Note
Keep this directory secure and never commit sensitive files to version control.
EOF
    echo -e "${GREEN}✓ Created VPN subdirectories${NC}"
else
    echo -e "${GREEN}✓ $VPN_DIR already exists${NC}"
fi

# Create .gitignore for VPN directory
GITIGNORE="$VPN_DIR/.gitignore"
if [ ! -f "$GITIGNORE" ]; then
    cat > "$GITIGNORE" << 'EOF'
# Ignore all VPN files for security
*
!.gitignore
!README.md
EOF
    echo -e "${GREEN}✓ Created .gitignore for VPN directory${NC}"
fi

# Check for common VPN tools
echo ""
echo "Checking for VPN tools..."

# OpenVPN
if command -v openvpn &> /dev/null; then
    echo -e "${GREEN}✓ OpenVPN is installed${NC}"
else
    echo -e "${YELLOW}⚠ OpenVPN is not installed. Install with: sudo pacman -S openvpn${NC}"
fi

# WireGuard
if command -v wg &> /dev/null; then
    echo -e "${GREEN}✓ WireGuard is installed${NC}"
else
    echo -e "${YELLOW}⚠ WireGuard is not installed. Install with: sudo pacman -S wireguard-tools${NC}"
fi

# StrongSwan (IPsec)
if command -v ipsec &> /dev/null; then
    echo -e "${GREEN}✓ StrongSwan is installed${NC}"
else
    echo -e "${YELLOW}⚠ StrongSwan is not installed. Install with: sudo pacman -S strongswan${NC}"
fi

echo ""
echo -e "${GREEN}✅ SSH and VPN setup completed!${NC}"
echo ""
echo "📝 Next steps:"
echo "  1. Add your SSH host configurations to ~/.ssh/config"
echo "  2. Add your public key to remote servers: ssh-copy-id user@host"
echo "  3. Place VPN configuration files in ~/.vpn/configs/"
echo "  4. Keep VPN certificates secure in ~/.vpn/certs/"

