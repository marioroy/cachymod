#!/bin/bash
# Installation script for POC Extra Utilities
# Installs utilities and configures hardened, passwordless sudo access.
#
# Author: Author: https://github.com/marioroy/cachymod

set -e  # Exit immediately if any command fails

BIN_DIR="/usr/local/bin"
SUDOERS_FILE="/etc/sudoers.d/90-poc-custom"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: This installation script must be run as root (sudo)." >&2
    exit 1
fi

echo "=========================================="
echo " Installing POC Extra Utilities"
echo "=========================================="

# Install wrapper scripts
echo "-> Copying scripts to $BIN_DIR..."
if [[ -f "utils/poc" && -f "utils/poc-smt" && -f "utils/poc-sticky" ]]; then
    mkdir -p "$BIN_DIR"
    cp "utils/poc" "utils/poc-smt" "utils/poc-sticky" "$BIN_DIR/"
    chmod +x "$BIN_DIR/poc" "$BIN_DIR/poc-smt" "$BIN_DIR/poc-sticky"
    echo "   Success: Installed poc, poc-smt, and poc-sticky."
else
    echo "Error: Source scripts 'poc', 'poc-smt' or 'poc-sticky' missing from utils directory." >&2
    exit 1
fi

# Deploy hardened sudoers rules
echo "-> Deploying secure sudoers configuration to $SUDOERS_FILE..."

# Using a strict HEREDOC with no indentations to prevent trailing spaces
cat << 'EOF' > "$SUDOERS_FILE"
# Prerequisite for Piece-Of-Cake (POC) Custom kernel optimization scripts
%wheel ALL=(ALL) NOPASSWD: \
  /usr/bin/sysctl kernel.sched_poc_prefer_idle_smt=0, \
  /usr/bin/sysctl kernel.sched_poc_prefer_idle_smt=1, \
  /usr/bin/sysctl kernel.sched_poc_target_sticky=0, \
  /usr/bin/sysctl kernel.sched_poc_target_sticky=1, \
  /usr/bin/sysctl kernel.sched_poc_selector=0, \
  /usr/bin/sysctl kernel.sched_poc_selector=1
EOF

# Set strict read-only permissions for sudoers
chmod 0440 "$SUDOERS_FILE"
echo "   Success: Configuration deployed with secure permissions (0440)."

# Verify syntax via visudo parsing engine
echo "-> Verifying sudoers configuration syntax..."
if visudo -cf "$SUDOERS_FILE" &>/dev/null; then
    echo "   Success: Syntax is valid."
else
    echo "Warning: visudo detected a potential syntax anomaly." >&2
    echo "Please check $SUDOERS_FILE." >&2
fi

echo "=========================================="
echo " Installation complete successfully!"
echo "=========================================="

