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

echo_mesg() {
  echo -e "${CYAN}${1}${NC}"
  echo
}

gum style \
  --border normal --padding "0 1" \
  --foreground="#E5BD1A" --bold \
  "CachyMod Uninstaller (requires sudo)"

cachymod=()
for kernel in $(cd /usr/src; ls -1dvr *cachymod* 2>/dev/null); do
  cachymod+=("$kernel")
done
if [ ${#cachymod[@]} -eq 0 ]; then
  echo_mesg "No CachyMod kernel found! Exiting..."
  exit
fi

kernels=$(
  printf "%s\n" "${cachymod[@]}" | gum choose \
    --header "Toggle the kernel(s) to uninstall:" \
    --header.foreground "#06989A" \
    --no-limit --height 14
)
if [ $? -ne 0 ]; then
  exit # pressed the Esc key or received a signal
elif [ -z "$kernels" ]; then
  echo "nothing selected"
  exit
fi

echo -e "${CYAN}checking package list...${NC}"

packages=()
for kernel in $kernels; do
  packages+=("$kernel")
  if pacman -Q "${kernel}-headers" &>/dev/null; then
    packages+=("${kernel}-headers")
  fi
  if pacman -Q "${kernel}-dbg" &>/dev/null; then
    packages+=("${kernel}-dbg")
  fi
done

sudo pacman -Rsn ${packages[@]}
sync

