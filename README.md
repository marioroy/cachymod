# CachyMod

Run a kernel with lazy preemption capability on [CachyOS](https://cachyos.org/).

If running NVIDIA graphics, first switch to DKMS for future proof CachyOS
updating the NVIDIA stack to a later release.

```bash
# Obtain a list of NVIDIA kernel modules.
pacman -Q | awk '/^linux-cachyos-.*nvidia/ { print $1 }'

# Remove any prebuilt NVIDIA kernel modules.
sudo pacman -Rsn linux-cachyos-nvidia
sudo pacman -Rsn linux-cachyos-nvidia-open

# Install NVIDIA sources for DKMS (choose one).
sudo pacman -Sy nvidia-550xx-dkms  # 6.13 needs 550.142.1 or later
sudo pacman -Sy nvidia-dkms        # 6.13 needs 565.77-5 or later
sudo pacman -Sy nvidia-open-dkms   # 6.13 needs 565.77-5 or later
```

## Building and Installation

Copy a `linux-cachymod-6.12/13` folder to a work area with ample storage space,
and change directory. Optionally, adjust the build options in `PKGBUILD.lazy.sh`.
Select `_preempt=rt` for the realtime kernel.

```bash
bash PKGBUILD.lazy.sh

# lazy
sudo pacman -U linux-cachymod-612-bore-lto-{6,h}*.zst
sudo pacman -U linux-cachymod-612-bore-polly-{6,h}*.zst
sudo pacman -U linux-cachymod-612-bore-clang-{6,h}*.zst
sudo pacman -U linux-cachymod-612-bore-gcc-{6,h}*.zst

# lazy-rt
sudo pacman -U linux-cachymod-612-bore-lto-rt*.zst
sudo pacman -U linux-cachymod-612-bore-polly-rt*.zst
sudo pacman -U linux-cachymod-612-bore-clang-rt*.zst
sudo pacman -U linux-cachymod-612-bore-gcc-rt*.zst
```

Removal is via pacman as well. Change the kernel version, build tag,
and build type accordingly to { 612, 613 }, { bore, eevdf }, and
{ lto, polly, clang, gcc }, respectively.

```text
# lazy
sudo pacman -Rsn \
  linux-cachymod-612-bore-gcc \
  linux-cachymod-612-bore-gcc-headers

# lazy-rt
sudo pacman -Rsn \
  linux-cachymod-612-bore-gcc-rt \
  linux-cachymod-612-bore-gcc-rt-headers
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

The `PKGBUILD.lazy.sh` script creates the `PKGBUILD` file.

Feel free to copy the `PKGBUILD.lazy.sh` script and name it
anything you like, and edit that file. I have four depending
on the type of kernel I want to build.

```text
# Fast localmod build.
mario.fast
mario.fast-rt

# Same thing, but without localmod.
mario.lazy
mario.lazy-rt
```

Optionally, change the first build option to have one script
for building bore or eevdf. Do this in your copy.

```text
export _prefer_eevdf="${_prefer_eevdf-}"
```

So now, I can build the eevdf or bore kernel with ease.

```text
_prefer_eevdf=y ./mario.fast
_prefer_eevdf=  ./mario.fast
```

Optionally, append kernel installation steps at the end of the script.

```text
# Wait for pacman to finish

while [ -e "/var/lib/pacman/db.lck" ]; do
  # sleep $((1 + RANDOM % 9))
    sleep 1
done

echo "Installing the kernel..."

if [[ "$_buildtype" = "thin" || "$_buildtype" = "full" ]]; then
    buildtype="lto"
else
    buildtype="$_buildtype"
fi

if [[ "$_prefer_eevdf" =~ (y|1) ]]; then
    buildtag="eevdf"
else
    buildtag="bore"
fi

sudo pacman -U --noconfirm linux-cachymod-612-${buildtag}-${buildtype}-{6,h}*

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

