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

## Utility dependency

The `confmod.sh` and `uninstall.sh` utilities use the `gum` command,
a tool for making shell scripts more glamorous.

```bash
sudo pacman -S gum
```

Optionally, copy the ready-made configs to your home folder.

```bash
mkdir -p ~/.config/cachymod
cp defconfigs/*.conf ~/.config/cachymod/
```

## Building and Installation

Run the `confmod.sh` script from inside the source dir, preferably,
to make changes or create new configs. Set your desired build options
and exit the main menu.

Note: The reason to run the utility from inside the source dir is in
the case having local patches. The `confmod.sh` has a file chooser
capability. Otherwise, it can be run from anywhere.

```bash
cd /path-to/cachymod/linux-cachymod-6.18
../confmod.sh
```

To build, run the `build.sh` script and pass the config name.
Omitting the config name will build a kernel with default options
(no kernel suffix). The utility handles installation as well.

```bash
./build.sh confname # E.g. 618, 618-bmq, 618-bore, 618-pds, 618-rt
```

The config names can be obtained with the `list` argument.

```bash
./build.sh list
618-rt
618-pds
618-bore
618-bmq
618
...
```

## Manual Installation

Below are the manual steps if needed.

The `d` in `[6dh]` will include the `dbg` package if built.
Adjust the kernel tag to your kernel suffix. Two sets of
examples are provided for demonstration.

```bash
sudo pacman -U linux-cachymod-[6dh]*.zst
sudo pacman -U linux-cachymod-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-bore-[6dh]*.zst
sudo pacman -U linux-cachymod-pds-[6dh]*.zst
sudo pacman -U linux-cachymod-rt-[6dh]*.zst

# with kernel tag
sudo pacman -U linux-cachymod-618-[6dh]*.zst
sudo pacman -U linux-cachymod-618-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-618-bore-[6dh]*.zst
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

This can be used with EEVDF and BORE.

## Developer Notes

Custom kernel tuning is possible via `custom.sh`, if it exists.
Make a copy of the sample provided and edit `custom.sh`. The file
is ignored from GIT commits.

```text
cp ../sample/custom.sh.in custom.sh
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

