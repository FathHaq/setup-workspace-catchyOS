#!/bin/bash

# Git Clone All Script
# Clone multiple repositories from a list file

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Default values
REPO_LIST_FILE="${1:-repos.txt}"
CLONE_DIR="${2:-$HOME/dev}"
GITHUB_USER="${GITHUB_USER:-}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

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

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if repo list file exists
if [ ! -f "$REPO_LIST_FILE" ]; then
    print_error "Repository list file not found: $REPO_LIST_FILE"
    echo ""
    echo "Usage: $0 [repo-list-file] [clone-directory]"
    echo ""
    echo "Example:"
    echo "  $0 repos.txt ~/dev"
    echo ""
    echo "Repository list file format (one per line):"
    echo "  https://github.com/user/repo.git"
    echo "  git@github.com:user/repo.git"
    echo "  user/repo  (will use https://github.com/user/repo.git)"
    echo "  # This is a comment"
    echo ""
    exit 1
fi

# Create clone directory if it doesn't exist
if [ ! -d "$CLONE_DIR" ]; then
    print_info "Creating directory: $CLONE_DIR"
    mkdir -p "$CLONE_DIR"
fi

cd "$CLONE_DIR"

# Count total repos (excluding comments and empty lines)
TOTAL_REPOS=$(grep -v '^#' "$REPO_LIST_FILE" | grep -v '^$' | wc -l | tr -d ' ')
CURRENT=0
SUCCESS=0
FAILED=0
SKIPPED=0

echo ""
print_info "Found $TOTAL_REPOS repositories to clone"
print_info "Clone directory: $CLONE_DIR"
echo ""

# Read and process each line
while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    
    CURRENT=$((CURRENT + 1))
    
    # Parse repository URL
    REPO_URL="$line"
    REPO_NAME=""
    
    # Handle different URL formats
    if [[ "$line" =~ ^https://github.com/(.+)/(.+)$ ]]; then
        REPO_NAME="${BASH_REMATCH[2]%.git}"
    elif [[ "$line" =~ ^git@github.com:(.+)/(.+)$ ]]; then
        REPO_NAME="${BASH_REMATCH[2]%.git}"
    elif [[ "$line" =~ ^(.+)/(.+)$ ]]; then
        # Format: user/repo
        REPO_URL="https://github.com/$line.git"
        REPO_NAME="${BASH_REMATCH[2]}"
    else
        print_warning "Skipping invalid format: $line"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi
    
    # Add authentication if token is provided
    if [ -n "$GITHUB_TOKEN" ] && [[ "$REPO_URL" =~ ^https://github.com ]]; then
        REPO_URL="${REPO_URL/https:\/\//https://${GITHUB_TOKEN}@}"
    fi
    
    echo -e "${BLUE}[$CURRENT/$TOTAL_REPOS]${NC} Cloning: $REPO_NAME"
    
    # Check if directory already exists
    if [ -d "$REPO_NAME" ]; then
        print_warning "Directory already exists: $REPO_NAME (skipping)"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi
    
    # Clone repository
    if git clone "$REPO_URL" "$REPO_NAME" 2>/dev/null; then
        print_status "Cloned: $REPO_NAME"
        SUCCESS=$((SUCCESS + 1))
    else
        print_error "Failed to clone: $REPO_NAME"
        FAILED=$((FAILED + 1))
    fi
    
    echo ""
done < "$REPO_LIST_FILE"

# Summary
echo "=========================================="
echo -e "${GREEN}Summary:${NC}"
echo "  Total:    $TOTAL_REPOS"
echo -e "  ${GREEN}Success:  $SUCCESS${NC}"
echo -e "  ${RED}Failed:   $FAILED${NC}"
echo -e "  ${YELLOW}Skipped:  $SKIPPED${NC}"
echo "=========================================="
echo ""

if [ $FAILED -gt 0 ]; then
    exit 1
fi

