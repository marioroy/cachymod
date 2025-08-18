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

Copy the `linux-cachymod-6.16` folder to a work area and change
directory. Optionally, adjust build options in `build.sh`.
Select `_preempt=rt` for the realtime kernel.

```bash
bash build.sh

# full or lazy preemption
sudo pacman -U linux-cachymod-616-lto-{6,h}*.zst
sudo pacman -U linux-cachymod-616-clang-{6,h}*.zst
sudo pacman -U linux-cachymod-616-gcc-{6,h}*.zst

# rt preemption
sudo pacman -U linux-cachymod-616-lto-rt*.zst
sudo pacman -U linux-cachymod-616-clang-rt*.zst
sudo pacman -U linux-cachymod-616-gcc-rt*.zst
```

Removal is via pacman as well. Change the build type accordingly.
Tip: `ls /usr/src` for the list of kernels installed on the system.

```text
# full or lazy preemption
sudo pacman -Rsn \
  linux-cachymod-616-lto \
  linux-cachymod-616-lto-headers

# rt preemption
sudo pacman -Rsn \
  linux-cachymod-616-lto-rt \
  linux-cachymod-616-lto-rt-headers
```

## Developer Notes

Feel free to copy the `build.sh` script, name it anything
you like, and edit that file. I have four depending on the
type of kernel I want to build.

```text
# fast localmod build
mario.fast
mario.fast-rt

# same thing, but without localmod
mario.lazy
mario.lazy-rt
```

Custom kernel tuning is possible via `custom.sh`, if it exists.
Make a copy of the sample provided and edit `custom.sh`. The file
is ignored from GIT commits.

```text
cp ../sample/custom.sh.in custom.sh
```

Optionally, append kernel installation steps at the end of the script.

```text
# Wait for pacman to finish

while [ -e "/var/lib/pacman/db.lck" ]; do
  # sleep $((1 + RANDOM % 9))
    sleep 1
done

echo "Installing the kernel..."

if [ -z "$_kernel_suffix" ]; then
    if [[ "$_buildtype" =~ ^(thin|full)$ ]]; then
        _kernel_suffix="lto"
    else
        _kernel_suffix="$_buildtype"
    fi
fi

if [[ "$_build_debug" =~ ^(yes|y|1)$ ]]; then
    sudo pacman -U --noconfirm linux-cachymod-616-${_kernel_suffix}-{6,d,h}*
else
    sudo pacman -U --noconfirm linux-cachymod-616-${_kernel_suffix}-{6,h}*
fi

sync
```

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

