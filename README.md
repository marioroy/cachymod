# CachyMod

Run a custom kernel on [CachyOS](https://cachyos.org/).

If running NVIDIA graphics, first switch to DKMS for future proof CachyOS
updating the NVIDIA stack to a later release.

```bash
# Obtain a list of NVIDIA kernel modules.
pacman -Q | awk '/^linux-cachyos-.*nvidia/ { print $1 }'

# Remove any prebuilt NVIDIA kernel modules.
sudo pacman -Rsn linux-cachyos-nvidia-open
sudo pacman -Rsn linux-cachyos-nvidia

# Install NVIDIA sources for DKMS (choose one).
sudo pacman -Sy nvidia-open-dkms
sudo pacman -Sy nvidia-dkms
```

## Building and Installation

There are no binary packages. One builds the kernel with `build.sh`.
The demonstrations are given for the 7.0 kernel.

```bash
# obtain CachyMod repo
git clone --depth=1 https://github.com/marioroy/cachymod.git
cd cachymod

# create the "cachymod" configuration folder
mkdir -p ~/.config/cachymod

# copy the build configs for a specific version or copy all
cp defconfigs/7.0/*.conf ~/.config/cachymod/
cp defconfigs/*/*.conf ~/.config/cachymod/

# the TUI tools require the gum package
sudo pacman -S gum

# make any adjustments with the confmod.sh TUI tool
cd linux-cachymod-7.0
../confmod.sh

# build CachyMod kernel (includes installation)
./build.sh list  # to get a list of build configs
./build.sh 70    # build kernel using the 70 config
```

To update, fetch the changes to automatically merge them into
your local CachyMod repo.

```bash
cd cachymod
git pull
```

## Manual Package Installation

Below are the manual steps if needed.

The `d` in `[67dh]` will include the `dbg` package if built.
Adjust the kernel tag to your kernel suffix. Two sets of
examples are provided for demonstration.

```bash
sudo pacman -U linux-cachymod-[67dh]*.zst
sudo pacman -U linux-cachymod-bmq-[67dh]*.zst
sudo pacman -U linux-cachymod-pds-[67dh]*.zst
sudo pacman -U linux-cachymod-rt-[67dh]*.zst

# with kernel tag
sudo pacman -U linux-cachymod-70-[67dh]*.zst
sudo pacman -U linux-cachymod-70-bmq-[67dh]*.zst
sudo pacman -U linux-cachymod-70-pds-[67dh]*.zst
sudo pacman -U linux-cachymod-70-rt-[67dh]*.zst
```

## Uninstall

The CachyMod kernel(s) can be removed with the `uninstall.sh`
utility. Run the script and toggle the kernels you wish to
uninstall. Then, press the `enter` key.

```bash
./uninstall.sh
```

## Improving Interactive Performance

Enable TEO (Timer Events Oriented) CPUIdle governor with modern x86-64
processors. Specifically, Intel 11th Gen (Rocket/Tiger Lake), 12th/13th/14th
Gen (Alder/Raptor Lake), AMD Ryzen 2000 series "Zen+" and newer are well
supported.

Do not enable if your CPU lacks the `MWAIT` extension. Ditto with Intel
10th Gen (Coment Lake), which may not play nice with TEO.

```bash
lscpu | grep -E 'monitor|mwait'

# Default to TEO via tmpfiles service
sudo mkdir -p /etc/tmpfiles.d

# Add entry to /etc/tmpfiles.d/tweaks.conf (create file if missing)
w! /sys/devices/system/cpu/cpuidle/current_governor - - - - teo
```

If you're running CPU-intensive background tasks or make jobs, refer to
[linux-cgroup-always](https://github.com/marioroy/linux-cgroup-always)
for Ghostty-like `linux-cgroup = always` feature with your terminal emulator.
This can be used with EEVDF/BORE and Real-time (RT) kernels.

## Developer Notes

If adding BORE patch, the official patch may not apply with recent kernels.
Try `0001-bore.patch` found at <https://github.com/CachyOS/kernel-patches/>.

Custom kernel tuning is possible via `custom.sh`, if it exists.
Make a copy of the sample provided and edit `custom.sh`. The file
is ignored from GIT commits.

```text
cp ../sample/custom.sh.in custom.sh
```

The kernel supports dynamic preemption. You can set the default with
boot option. See also, `preemption` script in the sample folder to
get/set the preemption mode dynamically.

```text
preempt=full
preempt=lazy
```

## Acknowledgement

Thank you, CachyOS community with sounding board and testing.

The `PKGBUILD` is based on CachyOS's `PKGBUILD` file.

The `minimal-modprobed.db` is from [linux-tkg](https://github.com/Frogging-Family/linux-tkg), used for making a diet kernel { `_localmodcfg=y` and `_localmodcfg_minimal=y` }.

## LICENSE

```text
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
at your option any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```

