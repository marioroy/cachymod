#!/bin/bash
# Kernel build script.

# Exit script immediately on error.
set -e

###############################################################################
# Build options. Unless selections given, answer "yes/y/1", "no/n/0" or "".
###############################################################################

# Select CPU scheduler { eevdf, bore, rt, bmq }
# eevdf: EEVDF Scheduler (use with the linux-cgroup-always repo, optional)
# bore:  EEVDF Scheduler with Burst-Oriented Response Enhancer
# rt:    EEVDF Scheduler with real-time preemption enabled
# bmq:   BitMap Queue Scheduler
: "${_cpusched:=eevdf}"

# Custom kernel suffix, specify uniquely if building multiple CachyMod kernels
# E.g. { blank value, bmq, bore, rt } or { 617, 617-bmq, 617-bore, 617-rt }
# Or set to "auto" for automatic suffix { gcc, clang, lto }
# Or set to blank value for no kernel suffix
: "${_kernel_suffix:=}"

# Prevent AVX2 floating-point instructions. (Clear and XanMod default)
: "${_prevent_avx2:=yes}"

# Run the "trim.sh" script to trim the kernel
# Deselects ~ 1,500 kernel options
: "${_runtrim_script:=yes}"

# Compile ONLY used modules to VASTLY reduce the number of modules built
# and the build time. Refer to the wiki page for more information.
# https://wiki.archlinux.org/index.php/Modprobed-db
#
# Installation:
#    sudo pacman -S modprobed-db
#    sudo modprobed-db store  (creates ~/.config/modprobed-db.conf)
#
# Be sure to run "store" from a stock CachyOS kernel at least once.
# Run subsequently to store any new module(s) to the database.
#    sudo modprobed-db store  (refreshes ~/.config/modprobed.db)
#
: "${_localmodcfg:=no}"
: "${_localmodcfg_path:=$HOME/.config/modprobed.db}"

# Include the modules in minimal-modprobed.db (use with _localmodcfg)
# This is the diet db from Linux-tkg
: "${_localmodcfg_minimal:=no}"

# Tweak kernel options prior to a build via nconfig, gconfig or xconfig
: "${_makenconfig:=no}"
: "${_makegconfig:=no}"
: "${_makexconfig:=no}"

# Transparent Hugepages { always, madvise }
: "${_hugepage:=always}"

# Enable TCP_CONG_BBR3
: "${_tcp_bbr3:=no}"

# Running tick rate { 1000, 800, 750, 600, 500 }
# Select 1000 if your machine has less than or equal to 16 CPUs.
# Select 800 if you want a balance between latency and performance,
# with more focus on latency. Otherwise, the best value is a mystery.
# If unsure, select 1000.
: "${_HZ_ticks:=1000}"

# Select tickless type { full, idle }
# Full tickless can give higher performances in various cases but, depending on
# hardware, lower consistency. Idle (without rcu_nocb_cpu) may reduce stutters.
: "${_ticktype:=full}"

# Select preemption { dynamic, voluntary, full, lazy }
# Select "dynamic" for runtime selectable none, voluntary, (full), or lazy.
# Select "voluntary" for desktop, matching the Clear kernel preemption.
# Select "full" for low-latency desktop, matching the CachyOS kernel preemption.
# Select "lazy" for low-latency desktop, for slightly better throughput.
: "${_preempt:=full}"

# Select CPU compiler optimization
# { generic, generic_v1, generic_v2, generic_v3, generic_v4, native, zen4 }
: "${_processor_opt:=}"

# Select build type { thin, clang, gcc }
# thin:  Build the kernel with clang thin-LTO, auto suffix "-lto"
#        Uses multiple threads, faster and lesser memory consumption,
#        possibly lower runtime performance than full
# clang: Build kernel with clang, auto suffix "-clang"
# gcc:   Build kernel with gcc, auto suffix "-gcc"
: "${_buildtype:=thin}"

# Build kernel with the AutoFDO profile?
# Ignored for clang and gcc build types
: "${_autofdo:=yes}"

# Add extra sources here: opt-in for the USB pollrate patch
# E.g. "${_extra_patch_or_url1:=1010-usb-pollrate.patch}"
# Refer to https://github.com/GloriousEggroll/Linux-Pollrate-Patch
# The 1???-*.patch files are ignored by git
: "${_extra_patch_or_url0:=}"
: "${_extra_patch_or_url1:=}"
: "${_extra_patch_or_url2:=}"
: "${_extra_patch_or_url3:=}"
: "${_extra_patch_or_url4:=}"
: "${_extra_patch_or_url5:=}"
: "${_extra_patch_or_url6:=}"
: "${_extra_patch_or_url7:=}"
: "${_extra_patch_or_url8:=}"
: "${_extra_patch_or_url9:=}"

# Build a debug package with non-stripped vmlinux
: "${_build_debug:=no}"

###############################################################################
# Build the kernel.
###############################################################################

export _extra_patch_or_url1 _extra_patch_or_url2 _extra_patch_or_url3
export _extra_patch_or_url4 _extra_patch_or_url5 _extra_patch_or_url6
export _extra_patch_or_url7 _extra_patch_or_url8 _extra_patch_or_url9
export _extra_patch_or_url0

export _localmodcfg _kernel_suffix _prevent_avx2 _runtrim_script
export _localmodcfg_path _makenconfig _makegconfig _makexconfig
export _localmodcfg_minimal _hugepage _HZ_ticks _ticktype _preempt
export _buildtype _build_debug _autofdo _processor_opt _tcp_bbr3
export _cpusched

# Build kernel and headers packages
time nice -n 15 ionice -n 1 makepkg -scf --cleanbuild --skipinteg || exit 1

