#!/usr/bin/env bash
# CachyMod kernel uninstaller script.

RED= CYAN= NC=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429)
  RED='\033[01;31m' CYAN='\033[00;36m' NC='\033[00m' # no color
fi

if ! command -v gum &>/dev/null; then
  echo -e "${RED}Oops! The 'gum' dependency is needed to run the script.${NC}"
  echo -e "Install gum and try again."
  echo
  echo -e "${CYAN}  sudo pacman -S gum${NC}"
  echo
  exit 1
fi

set -euo pipefail

echo_mesg() {
  echo -e "${CYAN}${1}${NC}"
  echo
}

gum style \
  --border normal --padding "0 1" \
  --foreground="#FCE94F" --bold \
  "CachyMod Uninstaller (requires sudo)"

cachymod=()
for kernel in $(cd /usr/src; ls -1d *cachymod* 2>/dev/null); do
  cachymod+=("$kernel")
done

if [ ${#cachymod[@]} -eq 0 ]; then
  echo_mesg "No CachyMod kernel found! Exiting..."
  exit 0
fi

cachymod+=("Exit") kernel=$(
  printf "%s\n" "${cachymod[@]}" |\
  gum choose --header.foreground "#06989A" --height 14
)
if [ "$kernel" = "Exit" ]; then
  echo_mesg "Exiting..."
  exit 0
fi

packages=("$kernel")
if pacman -Q "${kernel}-headers" &>/dev/null; then
  packages+=("${kernel}-headers")
fi
if pacman -Q "${kernel}-dbg" &>/dev/null; then
  packages+=("${kernel}-dbg")
fi

echo_mesg "Uninstalling ${kernel}..."
sudo pacman -Rsn ${packages[@]}

