# POC Extra Utilities

This directory contains utility wrapper scripts designed to easily toggle **Piece-Of-Cake (POC) Custom** kernel scheduler features on CachyOS. 

*   `poc`: The global master switch tool (`kernel.sched_poc_selector`).
*   `poc-smt`: Toggles the SMT idle preference (`kernel.sched_poc_prefer_idle_smt`).
*   `poc-sticky`: Toggles the L1/TLB cache affinity preference (`kernel.sched_poc_target_sticky`).

***

## 🚀 Installation & Uninstallation

### Install
Run the automated installation script to deploy the binaries from `utils/` to `/usr/local/bin/` and configure secure, passwordless `sudo` rights for these specific kernel options:

```bash
sudo ./install.sh
```

### Expected Installation Output
When you run the installer, it dynamically configures your `sudoers` file and validates its syntax using `visudo`. A successful installation will look like this:

```text
$ sudo ./install.sh 
==========================================
 Installing POC Extra Utilities
==========================================
-> Copying scripts to /usr/local/bin...
   Success: Installed poc, poc-smt, and poc-sticky.
-> Deploying secure sudoers configuration to /etc/sudoers.d/90-poc-custom...
   Success: Configuration deployed with secure permissions (0440).
-> Verifying sudoers configuration syntax...
   Success: Syntax is valid.
==========================================
 Installation complete successfully!
==========================================
```

### Uninstall
To completely remove the utilities and cleanly wipe the custom sudoers drop-in configuration from the system:

```bash
sudo ./uninstall.sh
```

***

## 📖 Usage Examples

All scripts support querying current values, setting values globally, or execution wrapping.

### Manual Toggling
*   **View current status:** `poc`
*   **Enable a feature:** `poc -e` or `poc --enable`
*   **Disable a feature:** `poc -d` or `poc --disable`

### POC Utility Matrix
| POC Command | Target Parameter | Default Policy | Ideal Workload Focus | Real-World Impact |
| :--- | :--- | :--- | :--- | :--- |
| `poc` | `selector` | Kernel default | Hot-path lookup accelerator | Shaves prime test from **12.33s to 12.18s** |
| `poc-smt -d` | `prefer_idle_smt=0` | **Active** (via `0280`) | Heavy Math / Pure Compute | Spreads tasks to empty cores (**12.18s** vs 13.32s) |
| `poc-smt -e` | `prefer_idle_smt=1` | On by default | Databases / Server I/O | Rockets Valkey from **2.06M to 2.37M RPS (+15.5%)** |
| `poc-sticky` | `target_sticky` | Off by default | Cache-heavy games (High Core CPUs) | Locks L1/TLB cache (Proven for **Cyberpunk 2077**) |

### Core Deployment Rules
*   **Gaming Launch Options:** Right-click a specific title like Cyberpunk 2077 in Steam ➔ Properties ➔ Launch Options: `poc-sticky %command%`
*   **Server Deployments:** Maximize concurrent text/memory pipelines by executing directly via the wrapper: `poc-smt -e valkey-server /path/to/valkey.conf`
*   **Modular Design:** While chaining is rarely necessary due to optimized kernel defaults, the independent structure easily allows it if an edge-case workload ever requires stacked options (e.g., `poc -e poc-smt -d server-job`).

***

## 🔋 Battery Savings vs. 🏎️ Extreme Performance

By default, the CachyMod kernel favors system efficiency and battery longevity, making them ideal for laptops and handhelds (like the Zen 4 AMD Z1 Extreme). However, if your machine is plugged into a wall or you are running a high-core workstation like a Threadripper, you can unleash massive performance gains by toggling full-idle cores.

*   Default Behavior (Idle-SMT Preference): Favors clustering tasks on active SMT threads first. This keeps processing localized, prevents unnecessary CPU wake-ups, and maximizes battery savings.
*   Performance Toggle (poc-smt -d): Forces the scheduler to search for pristine, physically fully-idle cores first. This eliminates hyper-threading contention and maximizes compute throughput for heavy game simulation engines.

```text
poc-smt -e %command%   # default
poc-smt -d %command%   # try with Forza Horizon 6
```

## 🎮 Steam Launch Options (Recommended for Cyberpunk 2077)

You can apply optimizations dynamically on a per-game basis directly within Steam without leaving the kernel feature permanently turned on. Right-click your game, go to **Properties**, and paste the wrapper into the **Launch Options** field:

```text
poc-smt -d poc-sticky -e %command%
```

Omitting the flag has the same effect as explicitly enabling the option.

```text
poc-sticky %command%
```

The scripts will automatically enable full-idle cores and your L1/TLB cache affinity preferences for the game and cleanly restore your global system defaults the second you exit the game.

## 🧮 Server Workloads & Optimization Chaining

For complex server environments or background compute jobs that benefit from full-idle cores, you can use `poc-smt`. This option can be invoked independently whether the master POC Selector is globally enabled or disabled.

```bash
poc-smt -d server-job
```

Because these tools are decoupled, they can be chained cleanly to stack optimization layers for a single runtime job—even if the subsystem is disabled globally:

```bash
poc -e poc-smt -d server-job
```

