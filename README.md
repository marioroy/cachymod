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

There are no binary packages. One builds the kernel with `build.sh`

```bash
# obtain CachyMod repo
git clone --depth=1 https://github.com/marioroy/cachymod.git
cd cachymod

# copy the build configs
mkdir -p ~/.config/cachymod
cp defconfigs/*.conf ~/.config/cachymod/

# the tui tools require the gum package
sudo pacman -S gum

# make any adjustments with the confmod.sh tui tool
cd linux-cachymod-6.18
../confmod.sh

# build CachyMod kernel (includes installation)
./build.sh list  # to get a list of build configs
./build.sh 618   # build kernel using the 618 config
```

To update, fetch the changes to automatically merge them into
your local CachyMod repo.

```bash
cd cachymod
git pull
```

## Manual Package Installation

Below are the manual steps if needed.

The `d` in `[6dh]` will include the `dbg` package if built.
Adjust the kernel tag to your kernel suffix. Two sets of
examples are provided for demonstration.

```bash
sudo pacman -U linux-cachymod-[6dh]*.zst
sudo pacman -U linux-cachymod-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-pds-[6dh]*.zst
sudo pacman -U linux-cachymod-rt-[6dh]*.zst

# with kernel tag
sudo pacman -U linux-cachymod-618-[6dh]*.zst
sudo pacman -U linux-cachymod-618-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-618-pds-[6dh]*.zst
sudo pacman -U linux-cachymod-618-rt-[6dh]*.zst
```

## Uninstall

The CachyMod kernel(s) can be removed with the `uninstall.sh`
utility. Run the script and toggle the kernels you wish to
uninstall. Then, press the `enter` key.

```bash
./uninstall.sh
```

## Improving Interactive Performance

If you're running CPU-intensive background tasks or make jobs, refer to
[linux-cgroup-always](https://github.com/marioroy/linux-cgroup-always)
for Ghostty-like `linux-cgroup = always` feature with your terminal emulator.

This can be used with EEVDF.

## Developer Notes

Custom kernel tuning is possible via `custom.sh`, if it exists.
Make a copy of the sample provided and edit `custom.sh`. The file
is ignored from GIT commits.

```text
cp ../sample/custom.sh.in custom.sh
```

## Acknowledgement

Thank you, CachyOS community with sounding board and testing.

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

