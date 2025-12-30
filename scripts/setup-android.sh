#!/bin/bash

# Android Development Setup Script
# Sets up KVM and Android Emulator permissions

set -e

echo "🤖 Setting up Android Development Environment..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please do not run this script as root${NC}"
    exit 1
fi

# Check if KVM is available
if [ ! -e /dev/kvm ]; then
    echo -e "${YELLOW}⚠ KVM device not found. Checking if virtualization is enabled...${NC}"
    
    if grep -q vmx /proc/cpuinfo || grep -q svm /proc/cpuinfo; then
        echo -e "${YELLOW}Virtualization is supported but KVM module might not be loaded.${NC}"
        echo "Trying to load KVM module..."
        sudo modprobe kvm
        sudo modprobe kvm_intel 2>/dev/null || sudo modprobe kvm_amd 2>/dev/null
        
        if [ -e /dev/kvm ]; then
            echo -e "${GREEN}✓ KVM module loaded${NC}"
        else
            echo -e "${RED}✗ Could not load KVM module. Please check your BIOS settings.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}✗ Virtualization is not supported or not enabled in BIOS${NC}"
        exit 1
    fi
fi

# Add user to kvm group
echo "Adding user to kvm group..."
if groups | grep -q kvm; then
    echo -e "${GREEN}✓ User already in kvm group${NC}"
else
    sudo usermod -aG kvm $USER
    echo -e "${GREEN}✓ User added to kvm group${NC}"
    echo -e "${YELLOW}⚠ You may need to log out and log back in for changes to take effect${NC}"
fi

# Set KVM device permissions
echo "Setting KVM device permissions..."
sudo chmod 666 /dev/kvm
echo -e "${GREEN}✓ KVM permissions set${NC}"

# Create udev rule for persistent KVM permissions
UDEV_RULE="/etc/udev/rules.d/99-kvm.rules"
if [ ! -f "$UDEV_RULE" ]; then
    echo "Creating udev rule for KVM..."
    echo 'KERNEL=="kvm", GROUP="kvm", MODE="0666"' | sudo tee "$UDEV_RULE" > /dev/null
    echo -e "${GREEN}✓ Udev rule created${NC}"
    
    # Reload udev rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    echo -e "${GREEN}✓ Udev rules reloaded${NC}"
else
    echo -e "${GREEN}✓ Udev rule already exists${NC}"
fi

# Check Android SDK location
if [ -d "$HOME/Android/Sdk" ]; then
    echo -e "${GREEN}✓ Android SDK found at $HOME/Android/Sdk${NC}"
    
    # Add Android SDK tools to PATH if not already there
    if ! grep -q "ANDROID_HOME" ~/.zshrc 2>/dev/null; then
        echo "" >> ~/.zshrc
        echo "# Android SDK" >> ~/.zshrc
        echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/tools" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/tools/bin" >> ~/.zshrc
        echo -e "${GREEN}✓ Android SDK paths added to .zshrc${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Android SDK not found. Install Android Studio to set up SDK.${NC}"
fi

# Check Flutter installation
echo ""
echo "Checking Flutter installation..."
if command -v flutter &> /dev/null; then
    echo -e "${GREEN}✓ Flutter is installed${NC}"
    flutter doctor
else
    echo -e "${YELLOW}⚠ Flutter not found in PATH${NC}"
    echo "Flutter should be installed via AUR (flutter package) or mise"
    echo "If installed via AUR, make sure to add it to PATH:"
    echo "  export PATH=\"\$PATH:\$HOME/flutter/bin\""
fi

echo ""
echo -e "${GREEN}✅ Android setup completed!${NC}"
echo ""
echo "📝 Next steps:"
echo "  1. If you were added to kvm group, log out and log back in"
echo "  2. Install Android Studio if not already installed"
echo "  3. Create an Android Virtual Device (AVD) in Android Studio"
echo "  4. Test the emulator with: emulator -avd <avd_name>"
echo "  5. Run 'flutter doctor' to verify Flutter setup"

