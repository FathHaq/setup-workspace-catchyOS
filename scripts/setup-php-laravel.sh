#!/bin/bash

# PHP Laravel Extensions Setup Script
# Ensures all required PHP extensions for Laravel are installed and configured

set -e

echo "🐘 Setting up PHP and Laravel extensions..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    echo -e "${RED}✗ PHP is not installed!${NC}"
    echo "Please install PHP first: sudo pacman -S php"
    exit 1
fi

PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
echo -e "${GREEN}✓ PHP $PHP_VERSION is installed${NC}"

# Required PHP extensions for Laravel
REQUIRED_EXTENSIONS=(
    "bcmath"
    "ctype"
    "curl"
    "dom"
    "fileinfo"
    "gd"
    "intl"
    "json"
    "mbstring"
    "openssl"
    "pdo"
    "pdo_mysql"
    "pdo_pgsql"
    "pdo_sqlite"
    "session"
    "tokenizer"
    "xml"
    "zip"
    "redis"
    "imagick"
)

echo ""
echo "Checking PHP extensions..."

MISSING_EXTENSIONS=()
for ext in "${REQUIRED_EXTENSIONS[@]}"; do
    if php -m | grep -qi "^$ext$"; then
        echo -e "${GREEN}✓${NC} $ext"
    else
        echo -e "${RED}✗${NC} $ext (missing)"
        MISSING_EXTENSIONS+=("$ext")
    fi
done

# Check if extensions need to be installed
if [ ${#MISSING_EXTENSIONS[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠ Missing extensions detected${NC}"
    echo "Please install missing extensions:"
    echo "  sudo pacman -S php-${MISSING_EXTENSIONS[0]}"
    
    for ext in "${MISSING_EXTENSIONS[@]:1}"; do
        echo "  sudo pacman -S php-$ext"
    done
else
    echo ""
    echo -e "${GREEN}✓ All required extensions are installed${NC}"
fi

# Check Composer
echo ""
echo "Checking Composer..."
if command -v composer &> /dev/null; then
    COMPOSER_VERSION=$(composer --version | head -n1)
    echo -e "${GREEN}✓ $COMPOSER_VERSION${NC}"
else
    echo -e "${YELLOW}⚠ Composer is not installed${NC}"
    echo "Install via mise or manually:"
    echo "  mise install composer"
fi

# PHP configuration recommendations
echo ""
echo "PHP Configuration Recommendations:"
echo "  - memory_limit: $(php -i | grep 'memory_limit' | head -n1 | awk '{print $3}')"
echo "  - upload_max_filesize: $(php -i | grep 'upload_max_filesize' | head -n1 | awk '{print $3}')"
echo "  - post_max_size: $(php -i | grep 'post_max_size' | head -n1 | awk '{print $3}')"

# Check php.ini location
PHP_INI=$(php --ini | grep "Loaded Configuration File" | awk '{print $4}')
if [ -n "$PHP_INI" ] && [ -f "$PHP_INI" ]; then
    echo ""
    echo "PHP Configuration file: $PHP_INI"
    echo ""
    echo "Recommended settings for Laravel (add to php.ini if needed):"
    echo "  memory_limit = 256M"
    echo "  upload_max_filesize = 20M"
    echo "  post_max_size = 20M"
    echo "  max_execution_time = 300"
    echo "  max_input_time = 300"
fi

echo ""
echo -e "${GREEN}✅ PHP Laravel setup check completed!${NC}"

