#!/bin/sh
set -e

# Function to get system architecture
get_architecture() {
    local arch="$(uname -m)"
    case "$arch" in
        x86_64|amd64) echo "amd64" ;;
        aarch64|arm64) echo "arm64" ;;
        armv7l) echo "armv7" ;;
        *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
    esac
}

# Install k9s from official GitHub release (prebuilt binary)
K9S_VERSION="0.32.4"
ARCH=$(get_architecture)
# k9s uses different naming convention for archives
case "$ARCH" in
    amd64) TAR_ARCH="amd64" ;;
    arm64) TAR_ARCH="arm64" ;;
    *) TAR_ARCH="amd64" ;;
esac
K9S_URL="https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_${TAR_ARCH}.tar.gz"
INSTALL_DIR="/usr/local/bin"

curl -fsSL -o /tmp/k9s.tar.gz "$K9S_URL"
tar -xzf /tmp/k9s.tar.gz -C /tmp
mv /tmp/k9s "$INSTALL_DIR/k9s"
chmod +x "$INSTALL_DIR/k9s"
echo "k9s installed: $($INSTALL_DIR/k9s version)"
# Test automation Tue Sep 23 19:56:28 BST 2025
