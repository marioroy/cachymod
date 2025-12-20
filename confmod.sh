#!/usr/bin/env bash
# CachyMod customization utility.
# The config files are saved in the ~/.config/cachymod/ folder.

FG="#06989A" RED= CYAN= NC=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429)
  RED='\e[01;31m' CYAN='\e[00;36m' NC='\e[00m' # no color
fi

if ! command -v gum &>/dev/null; then
  echo -e "${RED}This script requires the 'gum' dependency to run.${NC}"
  echo -e "Install gum and try again."
  echo
  echo -e "${CYAN}  sudo pacman -S gum${NC}"
  echo
  exit 1
fi

CONFIG_DIR=~/.config/cachymod
if [ ! -d "$CONFIG_DIR" ]; then
  if ! mkdir -p "$CONFIG_DIR" 2>/dev/null; then
    echo -e "${RED}Cannot mkdir '$CONFIG_DIR'. Exiting...${NC}"
    echo
    exit 1
  fi
fi

###############################################################################
# Terminal functions.
# https://github.com/dylanaraps/writing-a-tui-in-bash
###############################################################################

get_term_size() {
  # When checkwinsize is enabled and bash receives a command, it populates
  # the LINES and COLUMNS variables with the terminal size. The (:;:) snippet
  # works as a pseudo command without calling anything external.
  # Note: This works in Bash 4+ only.
  shopt -s checkwinsize; (:;:)
}

hide_cursor() {
  printf '\e[?25l'   # Hide the cursor
}

show_cursor() {
  printf '\e[?25h'   # Show the cursor
}

save_term() {
  printf '\e[?1049h' # Save the user's terminal screen
}

restore_term() {
  printf '\e[?1049l' # Restore the user's terminal screen
  show_cursor
}

###############################################################################
# Config functions.
###############################################################################

new_conf() {
  # Write a new configuration to file.
  local conf="$1"
  (
    echo ": \${_cpusched:=eevdf}"
    echo ": \${_buildtype:=thin}"
    echo ": \${_autofdo:=no}"
    echo ": \${_hugepage:=always}"
    echo ": \${_kernel_suffix:=${conf// /-}}"
    echo ": \${_localmodcfg:=no}"
    echo ": \${_localmodcfg_path:=modprobed.db}"
    echo ": \${_localmodcfg_minimal:=no}"
    echo ": \${_makenconfig:=no}"
    echo ": \${_makexconfig:=no}"
    echo ": \${_tcp_bbr3:=no}"
    echo ": \${_HZ_ticks:=1000}"
    echo ": \${_ticktype:=full}"
    echo ": \${_preempt:=full}"
    echo ": \${_processor_opt:=native}"
    echo ": \${_prevent_avx2:=no}"
    echo ": \${_build_debug:=no}"
    echo ": \${_extra_patch_or_url0:=}"
    echo ": \${_extra_patch_or_url1:=}"
    echo ": \${_extra_patch_or_url2:=}"
    echo ": \${_extra_patch_or_url3:=}"
    echo ": \${_extra_patch_or_url4:=}"
    echo ": \${_extra_patch_or_url5:=}"
    echo ": \${_extra_patch_or_url6:=}"
    echo ": \${_extra_patch_or_url7:=}"
    echo ": \${_extra_patch_or_url8:=}"
    echo ": \${_extra_patch_or_url9:=}"
  ) > "$CONFIG_DIR/$conf.conf"
}

save_conf() {
  # Write the configuration to file.
  local conf="$1"
  (
    echo ": \${_cpusched:=${_cpusched}}"
    echo ": \${_buildtype:=${_buildtype}}"
    echo ": \${_autofdo:=${_autofdo}}"
    echo ": \${_hugepage:=${_hugepage}}"
    echo ": \${_kernel_suffix:=${_kernel_suffix}}"
    echo ": \${_localmodcfg:=${_localmodcfg}}"
    echo ": \${_localmodcfg_path:=${_localmodcfg_path}}"
    echo ": \${_localmodcfg_minimal:=${_localmodcfg_minimal}}"
    echo ": \${_makenconfig:=${_makenconfig}}"
    echo ": \${_makexconfig:=${_makexconfig}}"
    echo ": \${_tcp_bbr3:=${_tcp_bbr3}}"
    echo ": \${_HZ_ticks:=${_HZ_ticks}}"
    echo ": \${_ticktype:=${_ticktype}}"
    echo ": \${_preempt:=${_preempt}}"
    echo ": \${_processor_opt:=${_processor_opt}}"
    echo ": \${_prevent_avx2:=${_prevent_avx2}}"
    echo ": \${_build_debug:=${_build_debug}}"
    echo ": \${_extra_patch_or_url0:=${_extra_patch_or_url0}}"
    echo ": \${_extra_patch_or_url1:=${_extra_patch_or_url1}}"
    echo ": \${_extra_patch_or_url2:=${_extra_patch_or_url2}}"
    echo ": \${_extra_patch_or_url3:=${_extra_patch_or_url3}}"
    echo ": \${_extra_patch_or_url4:=${_extra_patch_or_url4}}"
    echo ": \${_extra_patch_or_url5:=${_extra_patch_or_url5}}"
    echo ": \${_extra_patch_or_url6:=${_extra_patch_or_url6}}"
    echo ": \${_extra_patch_or_url7:=${_extra_patch_or_url7}}"
    echo ": \${_extra_patch_or_url8:=${_extra_patch_or_url8}}"
    echo ": \${_extra_patch_or_url9:=${_extra_patch_or_url9}}"
  ) > "$CONFIG_DIR/$conf.conf"
}

###############################################################################
# Input functions.
###############################################################################

emsg() {
  # Output message to standard error.
  echo -e "${CYAN}$1${NC}" >&2
}

choose() {
  # Chooser function using an array passed via name reference.
  local -n varref="$1";  local oldval="$varref" ans=
  local -n menuref="$2"; local header="$3" selected="$4"

  # Display an optional message string.
  [[ "$#" -gt 4 && -n "$5" ]] && emsg "$5"

  ans=$( printf "%s\n" "${menuref[@]}" | gum choose \
    --header "$header" \
    --header.foreground "$FG" \
    --height ${#menuref[@]} \
    --selected "$selected"
  )
  [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
  if [ -z "$ans" ]; then
    varref="$oldval" # pressed the Esc key
  else
    varref="${ans%:*}" # trim ':' character and everything to the right
  fi
}

confirm() {
  # Yes/no confirm function.
  local -n varref="$1"; local header="$2" menu=("yes" "no") selected=

  # Display an optional message string.
  [[ "$#" -gt 2 && -n "$3" ]] && emsg "$3"

  case "$varref" in
    yes|y|1) selected="${menu[0]}" ;;
     no|n|0) selected="${menu[1]}" ;;
          *) selected="${menu[1]}" ;;
  esac

  choose $1 menu "$header" "$selected"
}

input() {
  # Prompt function. 
  local -n varref="$1"; local oldval="$varref" maybe_url="$3" ans=
  emsg "$2"

  ans=$(gum input --placeholder "$oldval")
  [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
  if [ "$maybe_url" -eq 0 ]; then
    ans=${ans//[#$%!?:;,\"\|\(\)\{\}\[\]\<\>\`\\@\&\*^]/} # drop characters
  else
    ans=${ans//[#$%!?;,\"\|\(\)\{\}\[\]\<\>\`\\@\&\*^]/} # keep colon
  fi

  ans=$(echo $ans) # collapse multiple spaces
  [ -z "$ans" ] && ans="$oldval"
  [ "$ans" = "blank" ] && ans=""

  varref="$ans"
}

input_cpusched() {
  local -n varref="$1"; local menu=() selected=
  menu+=("eevdf: EEVDF Scheduler (use with linux-cgroup-always repo, optional)")
  menu+=("bore:  EEVDF Scheduler with Burst-Oriented Response Enhancer")
  menu+=("rt:    EEVDF Scheduler with real-time preemption enabled")
  menu+=("bmq:   BitMap Queue Scheduler")

  case "$varref" in
    eevdf) selected="${menu[0]}" ;;
    bore ) selected="${menu[1]}" ;;
    rt   ) selected="${menu[2]}" ;;
    bmq  ) selected="${menu[3]}" ;;
  esac

  choose $1 menu "Choose a CPU scheduler:" "$selected"
}

input_buildtype() {
  local -n varref="$1"; local menu=() selected=
  menu+=("gcc:   Build kernel with gcc; auto suffix '-gcc'")
  menu+=("clang: Build kernel with clang; auto suffix '-clang'")
  menu+=("thin:  Build kernel with clang thin-LTO; auto suffix '-lto'")

  case "$varref" in
    gcc  ) selected="${menu[0]}" ;;
    clang) selected="${menu[1]}" ;;
    thin ) selected="${menu[2]}" ;;
  esac

  choose $1 menu "Choose a build type:" "$selected"
}

input_autofdo() {
  local -n varref="$1"; local msg=
  msg+="Opt-in to include the AutoFDO profile when building the kernel.\n"
  msg+="Note: Some folks have reported lesser performance. (YMMV)\n"
  msg+="This is ignored for the 'clang' and 'gcc' build types.\n"

  confirm $1 "Build kernel with the AutoFDO profile?" "$msg"
}

input_hugepage() {
  local -n varref="$1"; local menu=() selected=
  menu+=("always:  Always enable THP")
  menu+=("madvise: Applications explicitly request THP")

  case "$varref" in
    always ) selected="${menu[0]}" ;;
    madvise) selected="${menu[1]}" ;;
  esac

  choose $1 menu "Choose Transparent Huge Pages (THP):" "$selected"
}

input_kernel_suffix() {
  local -n varref="$1"; local msg=
  msg+="Enter a custom kernel suffix?\n"
  msg+="E.g. { bmq, bore, rt } or { 618, 618-bmq, 618-bore, 618-rt }.\n"
  msg+="\n"
  msg+="Enter 'auto' for automatic suffix { gcc, clang, lto }.\n"
  msg+="Enter 'blank' to clear the value.\n"

  input $1 "$msg" 0
}

input_localmodcfg() {
  local -n varref="$1"; local msg=
  msg+="Compile ONLY used modules to VASTLY reduce the number of modules built\n"
  msg+="including the build time. Refer to the wiki page for more information.\n"
  msg+="https://wiki.archlinux.org/index.php/Modprobed-db\n"
  msg+="\n"
  msg+="  Installation:\n"
  msg+="    sudo pacman -S modprobed-db\n"
  msg+="    sudo modprobed-db store  (creates ~/.config/modprobed-db.conf)\n"
  msg+="\n"
  msg+="  Run 'store' from a stock CachyOS kernel at least once.\n"
  msg+="  Run subsequently to store any new module(s) to the database.\n"
  msg+="    sudo modprobed-db store  (refreshes ~/.config/modprobed.db)\n"

  confirm $1 "Enable localmodcfg?" "$msg"
}

input_localmodcfg_path() {
  local -n varref="$1"; local msg=
  msg+="Enter the localmod dbname (e.g. modprobed.db) or the full path?\n"
  msg+="The list of used modules can be found in the ~/.config/ folder.\n"
  msg+="\n"
  msg+="Enter 'blank' to clear the value.\n"

  input $1 "$msg" 0
}

input_localmodcfg_minimal() {
  local -n varref="$1"; local msg=
  msg+="The 'minimal-modprobed.db' is from Linux-tkg, referred to as diet db.\n"
  msg+="This can be used with the '_localmodcfg' option.\n"

  confirm $1 "Include the minimal-modprobed modules?" "$msg"
}

input_makenconfig() {
  local -n varref="$1"; local msg=
  msg+="The 'make nconfig' command is used to launch a text-based (ncurses)\n"
  msg+="menu interface for configuring the kernel, allowing users to select\n"
  msg+="features, drivers, and settings through an interactive, hierarchical\n"
  msg+="menu system.\n"

  confirm $1 "Tweak kernel options prior to a build via nconfig?" "$msg"
}

input_makexconfig() {
  local -n varref="$1"; local msg=
  msg+="The 'make xconfig' command is used to launch a graphical (Qt)\n"
  msg+="menu interface for configuring the kernel, allowing users to\n"
  msg+="select features, drivers, and settings through an interactive,\n"
  msg+="hierarchical menu system.\n"

  confirm $1 "Tweak kernel options prior to a build via xconfig?" "$msg"
}

input_tcp_bbr3() {
  local -n varref="$1"; local msg=
  msg+="TCP BBRv3 (Bottleneck Bandwidth and Round-trip time, Version 3)\n"
  msg+="is a TCP congestion control algorithm (CCA) developed by Google.\n"

  confirm $1 "Enable TCP_CONG_BBR3?" "$msg"
}

input_HZ_ticks() {
  local -n varref="$1"
  local menu=("1000" "800" "750" "625" "600" "500") selected="$varref" msg=
  msg+="Select 1000Hz if your machine has less than or equal to 16 CPUs.\n"
  msg+="Select 800Hz if you want a balance between latency and performance,\n"
  msg+="with more focus on latency. Otherwise, the best value is a mystery.\n"
  msg+="Select 625Hz or 500Hz if you want to minimize battery consumption.\n"

  choose $1 menu "Choose running tick rate:" "$selected" "$msg"
}

input_ticktype() {
  local -n varref="$1"; local menu=("full" "idle") selected="$varref" msg=
  msg+="Full tickless can give higher performances in various cases but,\n"
  msg+="depending on hardware, lower consistency.\n"
  msg+="Idle without rcu_nocb_cpu may reduce stutters.\n"

  choose $1 menu "Choose tickless type:" "$selected" "$msg"
}

input_preempt() {
  local -n varref="$1"; local menu=() selected=
  menu+=("dynamic:   for runtime selectable none, voluntary, full, or lazy")
  menu+=("voluntary: for desktop; matching the Clear kernel preemption")
  menu+=("full:      for low-latency desktop; matching the CachyOS preemption")
  menu+=("lazy:      for low-latency desktop; for slightly better throughput")

  case "$varref" in
    dynamic  ) selected="${menu[0]}" ;;
    voluntary) selected="${menu[1]}" ;;
    full     ) selected="${menu[2]}" ;;
    lazy     ) selected="${menu[3]}" ;;
  esac

  choose $1 menu "Choose kernel preemption:" "$selected"
}

input_processor_opt() {
  local -n varref="$1"; local menu=() selected=
  menu+=("generic:    Build for generic x86-64 CPU")
  menu+=("generic_v1: Build for generic x86-64 version 1 CPU")
  menu+=("generic_v2: Build for generic x86-64 version 2 CPU")
  menu+=("generic_v3: Build for generic x86-64 version 3 CPU")
  menu+=("generic_v4: Build for generic x86-64 version 4 CPU")
  menu+=("native:     Build and optimize for local/native CPU")
  menu+=("zen4:       Build and optimize for AMD Ryzen 4 CPU")

  case "$varref" in
    generic   ) selected="${menu[0]}" ;;
    generic_v1) selected="${menu[1]}" ;;
    generic_v2) selected="${menu[2]}" ;;
    generic_v3) selected="${menu[3]}" ;;
    generic_v4) selected="${menu[4]}" ;;
    native    ) selected="${menu[5]}" ;;
    zen4      ) selected="${menu[6]}" ;;
  esac

  choose $1 menu "Choose CPU compiler optimization:" "$selected"
}

input_prevent_avx2() {
  local -n varref="$1"; local msg=
  msg+="Prevent generating AVX2 floating-point code (Clear and XanMod default).\n"
  msg+="Running AVX2 instructions can lead to a slower frequency clock speed\n"
  msg+="on some Intel CPUs, due to power and thermal constraints.\n"

  confirm $1 "Prevent AVX2 floating-point instructions?" "$msg"
}

input_build_debug() {
  local -n varref="$1"

  confirm $1 "Build a debug package with non-stripped vmlinux?"
}

input_patch_or_url() {
  local -n varref="$1"; local oldval="$varref" num="$2" msg= ans=
  msg+="Enter the patch name or paste the URL for item $num?\n"
  msg+="\n"
  msg+="Enter 'blank' to clear the value.\n"
  msg+="Enter 'file' to choose a patch. The patch must reside\n"
  msg+="in the same folder as the PKGBUILD file.\n"

  input $1 "$msg" 1
  if [ "$varref" = "file" ]; then
    # TODO: gum file does not respect the height value
    # v0.17.0 version makes gum file command fail to correctly display
    # https://github.com/charmbracelet/gum/issues/969
    ans=$(gum file . --padding="2 0" --height=$((LINES - 6)) --file)
    [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
    [ "$ans" = "no file selected" ] && ans="$oldval"
    varref="${ans##*/}" # basename
  fi
}

###############################################################################
# Edit menu.
###############################################################################

edit_conf() {
  local conf="$1" menu= items= item= ans= oldval=
  local selected="Main menu"

  while true; do
    local _cpusched= _buildtype= _autofdo= _hugepage= _kernel_suffix=
    local _localmodcfg= _localmodcfg_path= _localmodcfg_minimal=
    local _makenconfig= _makexconfig= _tcp_bbr3= _HZ_ticks= _ticktype=
    local _preempt= _processor_opt= _prevent_avx2= _build_debug=
    local _extra_patch_or_url0= _extra_patch_or_url1= _extra_patch_or_url2=
    local _extra_patch_or_url3= _extra_patch_or_url4= _extra_patch_or_url5=
    local _extra_patch_or_url6= _extra_patch_or_url7= _extra_patch_or_url8=
    local _extra_patch_or_url9=

    source "$CONFIG_DIR/$conf.conf"

    hide_cursor; clear
    gum style \
      --border normal --padding "0 1" \
      --foreground "#E5BD1A" --bold \
      "CachyMod customization: $conf.conf"

    menu=("Main menu" "Delete config..." "Save as copy...")
    mapfile -t items < "$CONFIG_DIR/$conf.conf"
    for item in "${items[@]}"; do menu+=("$item"); done

    ans=$( printf "%s\n" "${menu[@]}" | gum choose \
      --header.foreground "$FG" \
      --height $((LINES - 8)) \
      --selected "$selected"
    )
    [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
    if [[ -z "$ans" || "$ans" = "Main menu" ]]; then
      return # pressed the Esc key or selected "Main menu"
    elif [ "$ans" = "Delete config..." ]; then
      selected="Delete config..."
      ans=$( gum confirm "Delete config '$conf'?" \
        --show-output --prompt.foreground "$FG"
      )
      [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
      if [[ "$ans" =~ "? Yes" ]]; then
        rm -f "$CONFIG_DIR/$conf.conf"
        return 1
      fi
      continue
    elif [ "$ans" = "Save as copy..." ]; then
      selected="Save as copy..."
      emsg "Copy config to a new name?"
      emsg "This will overwrite if the config exists.\n"

      ans=$(gum input --placeholder "")
      [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C

      ans=${ans//[#$%!?:;,\"\|\(\)\{\}\[\]\<\>\`\\@\&\*^]/} # drop characters
      ans=$(echo $ans) # collapse multiple spaces
      [ -z "$ans" ] && continue || ans="${ans%.conf}"

      conf="$ans" selected="Main menu"
      _kernel_suffix="${conf// /-}"
      save_conf "$conf"
      continue
    fi

    oldval=${ans#*=}    # trim left side, up to and including '='
    oldval=${oldval%\}} # chop '}'

    case "$ans" in
      ': ${_cpusched:='*)
        input_cpusched _cpusched
        selected=": \${_cpusched:=$_cpusched}"
        [ "$_cpusched" = "$oldval" ] && continue ;;

      ': ${_buildtype:='*)
        input_buildtype _buildtype
        selected=": \${_buildtype:=$_buildtype}"
        [ "$_buildtype" = "$oldval" ] && continue ;;

      ': ${_autofdo:='*)
        input_autofdo _autofdo
        selected=": \${_autofdo:=$_autofdo}"
        [ "$_autofdo" = "$oldval" ] && continue ;;

      ': ${_hugepage:='*)
        input_hugepage _hugepage
        selected=": \${_hugepage:=$_hugepage}"
        [ "$_hugepage" = "$oldval" ] && continue ;;

      ': ${_kernel_suffix:='*)
        input_kernel_suffix _kernel_suffix
        selected=": \${_kernel_suffix:=$_kernel_suffix}"
        [ "$_kernel_suffix" = "$oldval" ] && continue ;;

      ': ${_localmodcfg:='*)
        input_localmodcfg _localmodcfg
        selected=": \${_localmodcfg:=$_localmodcfg}"
        [ "$_localmodcfg" = "$oldval" ] && continue ;;

      ': ${_localmodcfg_path:='*)
        input_localmodcfg_path _localmodcfg_path
        selected=": \${_localmodcfg_path:=$_localmodcfg_path}"
        [ "$_localmodcfg_path" = "$oldval" ] && continue ;;

      ': ${_localmodcfg_minimal:='*)
        input_localmodcfg_minimal _localmodcfg_minimal
        selected=": \${_localmodcfg_minimal:=$_localmodcfg_minimal}"
        [ "$_localmodcfg_minimal" = "$oldval" ] && continue ;;

      ': ${_makenconfig:='*)
        input_makenconfig _makenconfig
        selected=": \${_makenconfig:=$_makenconfig}"
        [ "$_makenconfig" = "$oldval" ] && continue ;;

      ': ${_makexconfig:='*)
        input_makexconfig _makexconfig
        selected=": \${_makexconfig:=$_makexconfig}"
        [ "$_makexconfig" = "$oldval" ] && continue ;;

      ': ${_tcp_bbr3:='*)
        input_tcp_bbr3 _tcp_bbr3
        selected=": \${_tcp_bbr3:=$_tcp_bbr3}"
        [ "$_tcp_bbr3" = "$oldval" ] && continue ;;

      ': ${_HZ_ticks:='*)
        input_HZ_ticks _HZ_ticks
        selected=": \${_HZ_ticks:=$_HZ_ticks}"
        [ "$_HZ_ticks" = "$oldval" ] && continue ;;

      ': ${_ticktype:='*)
        input_ticktype _ticktype
        selected=": \${_ticktype:=$_ticktype}"
        [ "$_ticktype" = "$oldval" ] && continue ;;

      ': ${_preempt:='*)
        input_preempt _preempt
        selected=": \${_preempt:=$_preempt}"
        [ "$_preempt" = "$oldval" ] && continue ;;

      ': ${_processor_opt:='*)
        input_processor_opt _processor_opt
        selected=": \${_processor_opt:=$_processor_opt}"
        [ "$_processor_opt" = "$oldval" ] && continue ;;

      ': ${_prevent_avx2:='*)
        input_prevent_avx2 _prevent_avx2
        selected=": \${_prevent_avx2:=$_prevent_avx2}"
        [ "$_prevent_avx2" = "$oldval" ] && continue ;;

      ': ${_build_debug:='*)
        input_build_debug _build_debug
        selected=": \${_build_debug:=$_build_debug}"
        [ "$_build_debug" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url0:='*)
        input_patch_or_url _extra_patch_or_url0 "0"
        selected=": \${_extra_patch_or_url0:=$_extra_patch_or_url0}"
        [ "$_extra_patch_or_url0" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url1:='*)
        input_patch_or_url _extra_patch_or_url1 "1"
        selected=": \${_extra_patch_or_url1:=$_extra_patch_or_url1}"
        [ "$_extra_patch_or_url1" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url2:='*)
        input_patch_or_url _extra_patch_or_url2 "2"
        selected=": \${_extra_patch_or_url2:=$_extra_patch_or_url2}"
        [ "$_extra_patch_or_url2" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url3:='*)
        input_patch_or_url _extra_patch_or_url3 "3"
        selected=": \${_extra_patch_or_url3:=$_extra_patch_or_url3}"
        [ "$_extra_patch_or_url3" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url4:='*)
        input_patch_or_url _extra_patch_or_url4 "4"
        selected=": \${_extra_patch_or_url4:=$_extra_patch_or_url4}"
        [ "$_extra_patch_or_url4" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url5:='*)
        input_patch_or_url _extra_patch_or_url5 "5"
        selected=": \${_extra_patch_or_url5:=$_extra_patch_or_url5}"
        [ "$_extra_patch_or_url5" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url6:='*)
        input_patch_or_url _extra_patch_or_url6 "6"
        selected=": \${_extra_patch_or_url6:=$_extra_patch_or_url6}"
        [ "$_extra_patch_or_url6" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url7:='*)
        input_patch_or_url _extra_patch_or_url7 "7"
        selected=": \${_extra_patch_or_url7:=$_extra_patch_or_url7}"
        [ "$_extra_patch_or_url7" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url8:='*)
        input_patch_or_url _extra_patch_or_url8 "8"
        selected=": \${_extra_patch_or_url8:=$_extra_patch_or_url8}"
        [ "$_extra_patch_or_url8" = "$oldval" ] && continue ;;

      ': ${_extra_patch_or_url9:='*)
        input_patch_or_url _extra_patch_or_url9 "9"
        selected=": \${_extra_patch_or_url9:=$_extra_patch_or_url9}"
        [ "$_extra_patch_or_url9" = "$oldval" ] && continue ;;

      *) continue ;; # not reached
    esac

    # not reached unless an item is modified
    save_conf "$conf"
  done
}

###############################################################################
# Main menu.
###############################################################################

main_loop() {
  local menu= files= file= conf=
  local selected="New/Open config..."

  while true; do
    hide_cursor; clear
    gum style \
      --border normal --padding "0 1" \
      --foreground "#E5BD1A" --bold \
      "CachyMod customization: Main Menu"

    menu=("New/Open config..." "Exit")
    # populate the files array using natural sort in reverse order
    mapfile -t files < <(cd ~/.config/cachymod; ls -1dvr *.conf 2>/dev/null)
    for file in "${files[@]}"; do menu+=("${file%.conf}"); done

    conf=$( printf "%s\n" "${menu[@]}" | gum choose \
      --header.foreground "$FG" \
      --height $((LINES - 8)) \
      --selected "$selected"
    )
    [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C
    if [[ -z "$conf" || "$conf" = "Exit" ]]; then
      return # pressed the Esc key or selected "Exit"
    elif [ "$conf" = "New/Open config..." ]; then
      selected="New/Open config..."
      emsg "Enter new config name? E.g. 618, 618-bore, 618-bmq"
      emsg "This will open the config if it exists.\n"

      conf=$(gum input --placeholder "")
      [ $? -gt 1 ] && exit # received a signal e.g. Ctrl-C

      conf=${conf//[#$%!?:;,\"\|\(\)\{\}\[\]\<\>\`\\@\&\*^]/} # drop characters
      conf=$(echo $conf) # collapse multiple spaces
      [ -z "$conf" ] && continue || conf="${conf%.conf}"

      if [ ! -s "$CONFIG_DIR/$conf.conf" ]; then
        new_conf "$conf"
      fi
    fi

    if ! edit_conf "$conf"; then
      selected="New/Open config..." # config deleted
    else
      selected="$conf"
    fi
  done
}

save_term; trap 'restore_term' EXIT
get_term_size
main_loop
