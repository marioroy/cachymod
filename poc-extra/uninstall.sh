#!/bin/bash
# Uninstallation script for POC Extra Utilities
# Removes installed utilities and cleans up the custom sudoers configuration.
#
# Author: https://github.com/marioroy/cachymod

set -e  # Exit immediately if any command fails

BIN_DIR="/usr/local/bin"
SUDOERS_FILE="/etc/sudoers.d/90-poc-custom"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: This uninstallation script must be run as root (sudo)." >&2
    exit 1
fi

echo "=========================================="
echo " Uninstalling POC Extra Utilities"
echo "=========================================="

# Remove wrapper scripts
echo "-> Removing binaries from $BIN_DIR..."
removed_bin=0

if [ -f "$BIN_DIR/poc" ]; then
    rm "$BIN_DIR/poc"
    echo "   Removed: poc"
    removed_bin=1
fi

if [ -f "$BIN_DIR/poc-smt" ]; then
    rm "$BIN_DIR/poc-smt"
    echo "   Removed: poc-smt"
    removed_bin=1
fi

if [ -f "$BIN_DIR/poc-sticky" ]; then
    rm "$BIN_DIR/poc-sticky"
    echo "   Removed: poc-sticky"
    removed_bin=1
fi

if [ "$removed_bin" -eq 0 ]; then
    echo "   No wrapper binaries found in $BIN_DIR."
fi

# Clean up sudoers rule drop-in
echo "-> Cleaning up sudoers configuration..."
if [ -f "$SUDOERS_FILE" ]; then
    rm "$SUDOERS_FILE"
    echo "   Removed: $SUDOERS_FILE"
else
    echo "   No custom sudoers configuration found to remove."
fi

echo "=========================================="
echo " Uninstallation complete successfully!"
echo "=========================================="

