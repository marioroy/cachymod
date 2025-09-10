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
directory. Optionally, adjust the build options in `build.sh`.
Select `_preempt=rt` for the realtime kernel.

Change the build type { lto, clang, gcc }, accordingly.

```bash
bash build.sh

# BORE full/lazy or RT preemption
sudo pacman -U linux-cachymod-bore-lto-{6,h}*.zst
sudo pacman -U linux-cachymod-bore-lto-rt*.zst

# EEVDF full/lazy or RT preemption
sudo pacman -U linux-cachymod-eevdf-lto-{6,h}*.zst
sudo pacman -U linux-cachymod-eevdf-lto-rt*.zst
```

Removal is via pacman as well.

Tip: `ls /usr/src` for the list of kernels on the system.
Copy the file name and append "-headers" for the 2nd
package name.

```text
# BORE full/lazy or RT preemption
sudo pacman -Rsn \
  linux-cachymod-bore-lto \
  linux-cachymod-bore-lto-headers

sudo pacman -Rsn \
  linux-cachymod-bore-lto-rt \
  linux-cachymod-bore-lto-rt-headers

# EEVDF full/lazy or RT preemption
sudo pacman -Rsn \
  linux-cachymod-eevdf-lto \
  linux-cachymod-eevdf-lto-headers

sudo pacman -Rsn \
  linux-cachymod-eevdf-lto-rt \
  linux-cachymod-eevdf-lto-rt-headers
```

## Developer Notes

Feel free to copy the `build.sh` script, name it anything
you like, and edit that file. I have four depending on the
type of kernel I want to build.

```text
# fast localmod build `_preempt=full`
mario.fast
mario.fast-rt

# same thing, but without localmod `_preempt=full`
mario.full
mario.full-rt
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
while [ -e "/var/lib/pacman/db.lck" ]; do sleep 1; done

echo "Installing the kernel..."
[[ "$_include_bore" =~ ^(yes|y|1)$ ]] \
    && buildtag="bore" || buildtag="eevdf"

[[ "$_buildtype" =~ ^(thin|full)$ ]] \
    && buildtype="lto" || buildtype="$_buildtype"

if [ "$_kernel_suffix" = "auto" ]; then
    kernel_suffix="${buildtag}-${buildtype}"
elif [ -n "$_kernel_suffix" ]; then
    kernel_suffix="${buildtag}-${_kernel_suffix}"
else
    kernel_suffix="${buildtag}"
fi

[ "$_preempt" = "rt" ] && kernel_suffix="${kernel_suffix}-rt"

if [[ "$_build_debug" =~ ^(yes|y|1)$ ]]; then
    sudo pacman -U --noconfirm linux-cachymod-${kernel_suffix}-{6,d,h}*
else
    sudo pacman -U --noconfirm linux-cachymod-${kernel_suffix}-{6,h}*
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

