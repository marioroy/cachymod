# CachyMod

Run a 6.11 or 6.12 kernel with lazy preemption capability on [CachyOS](https://cachyos.org/).

If running NVIDIA graphics, first switch to DKMS for future proof CachyOS
updating the NVIDIA stack to a later release.

```bash
# Obtain a list of NVIDIA kernel modules.
pacman -Q | awk '/^linux-cachyos-.*nvidia/ { print $1 }'

# Remove any prebuilt NVIDIA kernel modules.
sudo pacman -Rsn linux-cachyos-nvidia
sudo pacman -Rsn linux-cachyos-nvidia-open

# Install NVIDIA sources for DKMS (choose one).
sudo pacman -S nvidia-dkms
sudo pacman -S nvidia-open-dkms
```

## Building and Installation

Copy a `linux-cachymod-6.11/12` folder to a work area with ample storage space,
and change directory. Optionally, adjust the build options in `PKGBUILD.lazy.sh`.
Select `_preempt=rt` for the realtime kernel.

```bash
bash PKGBUILD.lazy.sh

# lazy
sudo pacman -U linux-cachymod-611-lto-{6,h}*.zst
sudo pacman -U linux-cachymod-611-clang-{6,h}*.zst
sudo pacman -U linux-cachymod-611-gcc-{6,h}*.zst

# lazy-rt
sudo pacman -U linux-cachymod-611-lto-rt*.zst
sudo pacman -U linux-cachymod-611-clang-rt*.zst
sudo pacman -U linux-cachymod-611-gcc-rt*.zst
```

Removal is via pacman as well. Change the kernel version and
build type accordingly to { 611, 612 } and { lto, clang, gcc },
respectively.

```text
# lazy
sudo pacman -Rsn \
  linux-cachymod-611-gcc \
  linux-cachymod-611-gcc-headers

# lazy-rt
sudo pacman -Rsn \
  linux-cachymod-611-gcc-rt \
  linux-cachymod-611-gcc-rt-headers
```

The desired preemption can be specified with a kernel argument.
For most cases "full" is what you want for low-latency.

```bash
# lazy
preempt=voluntary
preempt=full (default)
preempt=lazy
preempt=none

# lazy-rt
preempt=full (default)
preempt=lazy
```

## Developer Notes

1. The `PKGBUILD.lazy.sh` script creates the `PKGBUILD` file.

2. I learned a lot making this project. Here's a tip.

Feel free to copy the `PKGBUILD.lazy.sh` script and name it
anything you like, and edit that file. I have four depending
on the type of kernel I want to build. Optionally, add the
`pacman` command to install the kernel.

```text
# Fast localmod build including trim.
mario.fast
mario.fast-rt

# Same thing, but without localmod.
mario.lazy
mario.lazy-rt
```

3. The 6.12 kernel will not work with the NVIDIA 550xx driver. 

I applied `0006-nvidia-drm-Set-FOP_UNSIGNED_OFFSET-for-nv_drm_fops.f.patch`
to `/usr/src/nvidia-550.127.05`, and the kernel works well. Ask kindly the
CachyOS team to include the patch for the 550xx driver.

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

