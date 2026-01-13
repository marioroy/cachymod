#!/bin/bash
# CachyMod build and installation script.

if [[ "$#" -gt 0 && "$1" =~ ^(-h|--help|help)$ ]]; then
  echo "Usage: $0 [ confname | list ]"
  exit
fi

if [[ "$#" -gt 0 && "$1" =~ ^(-l|--list|list)$ ]]; then
  # Display the list of confs using natural sort in reverse order.
  confs=$( ls -1dvr ~/.config/cachymod/*.conf 2>/dev/null )
  if [ -z "$confs" ]; then
    msg="Zero CachyMod configs. Run the 'confmod.sh' utility to make one."
    echo -e "$msg\n"
  else
    echo "$confs" | sed -e 's!.*/!!' -e 's!\.conf$!!'
  fi
  exit
fi

###############################################################################

RED= CYAN= NC=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429)
  RED='\e[01;31m' CYAN='\e[00;36m' NC='\e[00m' # no color
fi

if [ "$#" -gt 0 ]; then
  # Source the specified config.
  conf="$1"; conf="${conf%.conf}"

  if [ ! -e ~/.config/cachymod/$conf.conf ]; then
    echo -e "${RED}ERROR:${NC} '~/.config/cachymod/$conf.conf' does not exist."
    echo -e "Run the ../confmod.sh utility or try again."
    echo
    exit 1
  fi

  source ~/.config/cachymod/$conf.conf

else
  # Use defaults.
  : ${_cpusched:=eevdf}
  : ${_buildtype:=thin}
  : ${_autofdo:=no}
  : ${_autofdo_profile_name:=cachymod.afdo}
  : ${_hugepage:=always}
  : ${_kernel_suffix:=}
  : ${_localmodcfg:=no}
  : ${_localmodcfg_path:=modprobed.db}
  : ${_localmodcfg_minimal:=no}
  : ${_makenconfig:=no}
  : ${_makexconfig:=no}
  : ${_tcp_bbr3:=no}
  : ${_HZ_ticks:=1000}
  : ${_ticktype:=full}
  : ${_preempt:=full}
  : ${_processor_opt:=native}
  : ${_prevent_avx2:=no}
  : ${_build_debug:=no}
  : ${_extra_patch_or_url0:=}
  : ${_extra_patch_or_url1:=}
  : ${_extra_patch_or_url2:=}
  : ${_extra_patch_or_url3:=}
  : ${_extra_patch_or_url4:=}
  : ${_extra_patch_or_url5:=}
  : ${_extra_patch_or_url6:=}
  : ${_extra_patch_or_url7:=}
  : ${_extra_patch_or_url8:=}
  : ${_extra_patch_or_url9:=}
fi

export _cpusched _buildtype _autofdo _hugepage _kernel_suffix
export _localmodcfg _localmodcfg_path _localmodcfg_minimal
export _makenconfig _makexconfig _tcp_bbr3 _HZ_ticks _ticktype
export _preempt _processor_opt _prevent_avx2 _build_debug
export _extra_patch_or_url0 _extra_patch_or_url1 _extra_patch_or_url2
export _extra_patch_or_url3 _extra_patch_or_url4 _extra_patch_or_url5
export _extra_patch_or_url6 _extra_patch_or_url7 _extra_patch_or_url8
export _extra_patch_or_url9 _autofdo_profile_name

# Build and install the CachyMod kernel.
time nice -n 15 ionice -n 1 \
  makepkg -Ascif --cleanbuild --skipinteg --noconfirm || exit 1

sync

