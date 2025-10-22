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

## Building

Copy the `linux-cachymod-6.17` folder to a work area and change
directory. Optionally, adjust the build options in `build.sh`.
If building multiple CachyMod variants, the `env` command can
be used to specify the values uniquely.

```bash
bash build.sh

env _cpusched=eevdf _kernel_suffix= bash build.sh
env _cpusched=bore _kernel_suffix=bore bash build.sh
env _cpusched=bmq _kernel_suffix=bmq bash build.sh
env _cpusched=rt _kernel_suffix=rt bash build.sh

# with kernel tag
env _cpusched=eevdf _kernel_suffix=617 bash build.sh
env _cpusched=bore _kernel_suffix=617-bore bash build.sh
env _cpusched=bmq _kernel_suffix=617-bmq bash build.sh
env _cpusched=rt _kernel_suffix=617-rt bash build.sh
```

## Installation

The `d` in `[6dh]` will include the `dbg` package if built.

```bash
sudo pacman -U linux-cachymod-[6dh]*.zst
sudo pacman -U linux-cachymod-bore-[6dh]*.zst
sudo pacman -U linux-cachymod-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-rt-[6dh]*.zst

# with kernel tag
sudo pacman -U linux-cachymod-617-[6dh]*.zst
sudo pacman -U linux-cachymod-617-bore-[6dh]*.zst
sudo pacman -U linux-cachymod-617-bmq-[6dh]*.zst
sudo pacman -U linux-cachymod-617-rt-[6dh]*.zst
```

## Uninstall

Removal is via pacman as well.

Tip: `ls /usr/src` for the list of kernels on the system.
Copy the folder name and append "-headers" for the 2nd
package name. Include 3rd package "-dbg" if you selected
`_build_debug` and installed on the system.

```text
sudo pacman -Rsn \
  linux-cachymod linux-cachymod-headers

# include debug package
sudo pacman -Rsn \
  linux-cachymod linux-cachymod-headers \
  linux-cachymod-dbg
```

## Improving Interactive Performance

If you're running CPU-intensive background tasks or make jobs, refer to
[linux-cgroup-always](https://github.com/marioroy/linux-cgroup-always)
for Ghostty-like `linux-cgroup = always` feature with your terminal emulator.

This can be used with EEVDF and BORE.

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
[[ "$_buildtype" =~ ^(thin|full)$ ]] \
    && buildtype="lto" || buildtype="$_buildtype"

if [ "$_kernel_suffix" = "auto" ]; then
    kernel_suffix="$buildtype"
elif [ -n "$_kernel_suffix" ]; then
    kernel_suffix="$_kernel_suffix"
else
    kernel_suffix=""
fi

if [ -n "$kernel_suffix" ]; then
    sudo pacman -U --noconfirm linux-cachymod-${kernel_suffix}-[6dh]*
else
    sudo pacman -U --noconfirm linux-cachymod-[6dh]*
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

