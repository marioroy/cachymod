#!/bin/bash
# Set extra kernel options.

### Exit immediately on error.
set -e

### Decrease the kernel log buffer size (default 17).
scripts/config --set-val LOG_BUF_SHIFT 16

### Decrease the maximum number of vCPUs per KVM guest.
scripts/config --set-val KVM_MAX_NR_VCPUS 128

### Enable ACPI options. (default -m)
scripts/config -e ACPI_TAD -e ACPI_VIDEO -e ACPI_WMI

### Enable input device support (default -m)
scripts/config -e INPUT_FF_MEMLESS
scripts/config -e INPUT_SPARSEKMAP
scripts/config -e INPUT_MATRIXKMAP
scripts/config -e INPUT_VIVALDIFMAP

### Enable input modules. (default -m)
scripts/config -e SERIO -e SERIO_I8042 -e SERIO_LIBPS2 -e UHID -e USB_HID
scripts/config -e HID_APPLE -e HID_BELKIN -e HID_CHERRY -e HID_CHICONY
scripts/config -e HID_GENERIC -e HID_HOLTEK -e HID_KENSINGTON -e HID_LENOVO
scripts/config -e HID_LOGITECH -e HID_LOGITECH_DJ -e HID_LOGITECH_HIDPP
scripts/config -e HID_MICROSOFT -e HID_SAMSUNG -e HID_VIVALDI
scripts/config -e SERIO_GPIO_PS2 -e SERIO_SERPORT

### Enable storage modules. (default -m)
scripts/config -e BLK_DEV_DM -e BLK_DEV_LOOP -e BLK_DEV_NVME
scripts/config -e BLK_DEV_MD -d MD_AUTODETECT -d DM_INIT

### Enable file systems. (default -m)
scripts/config -d MSDOS_FS -e FAT_FS -e VFAT_FS

### Set tree-based hierarchical RCU fanout value. (default 64)
scripts/config --set-val RCU_FANOUT 32

### Disable poison kernel stack before returning from syscalls.
scripts/config -d KSTACK_ERASE

### Disable memory hotplug not needed for desktop use.
scripts/config -d MEMORY_HOTPLUG

### Disable auxiliary POSIX clocks.
scripts/config -d POSIX_AUX_CLOCKS

### Disable AppArmor support.
scripts/config -d SECURITY_APPARMOR

### Disable symbolic error names in printf and verbose BUG() reporting.
### XanMod default with the 18/20 patch in 0210.
scripts/config -d SYMBOLIC_ERRNAME -d DEBUG_BUGVERBOSE

### Disable boot config support.
scripts/config -d BOOTTIME_TRACING -d BOOT_CONFIG

### Disable powersave by default for wireless network.
scripts/config -d CFG80211_DEFAULT_PS

### Disable core dump support.
scripts/config -d COREDUMP

### Disable early printk.
scripts/config -d EARLY_PRINTK

### Disable hibernation (aka 'suspend to disk').
scripts/config -d HIBERNATION

### Disable kexec handover.
scripts/config -d KEXEC_HANDOVER

### Disable check for low memory corruption.
scripts/config -d X86_CHECK_BIOS_CORRUPTION

### Disable legacy vsyscall, ioperm, and iopl emulation.
scripts/config -d X86_VSYSCALL_EMULATION
scripts/config -d X86_IOPL_IOPERM

### Disable detect hung tasks.
scripts/config -d DETECT_HUNG_TASK
scripts/config -d HARDLOCKUP_DETECTOR
scripts/config -d SOFTLOCKUP_DETECTOR_INTR_STORM
scripts/config -d SOFTLOCKUP_DETECTOR

### Disable tracers.
scripts/config -d ATH5K_TRACER
scripts/config -d DM_UEVENT
scripts/config -d EPROBE_EVENTS
scripts/config -d FUNCTION_PROFILER
scripts/config -d FTRACE_RECORD_RECURSION
scripts/config -d FTRACE_SORT_STARTUP_TEST
scripts/config -d FTRACE_VALIDATE_RCU_IS_WATCHING
scripts/config -d HWLAT_TRACER
scripts/config -d IRQSOFF_TRACER
scripts/config -d KPROBE_EVENTS_ON_NOTRACE
scripts/config -d LOCK_EVENT_COUNTS
scripts/config -d MMIOTRACE
scripts/config -d MMIOTRACE_TEST
scripts/config -d OSNOISE_TRACER
scripts/config -d PM_DEVFREQ_EVENT
scripts/config -d PREEMPT_TRACER
scripts/config -d PSTORE_FTRACE
scripts/config -d TIMERLAT_TRACER
scripts/config -d SYNTH_EVENTS
scripts/config -d USER_EVENTS
scripts/config -d HIST_TRIGGERS
scripts/config -d TRACE_GPU_MEM

### Disable debug.
scripts/config -d SLUB_DEBUG
scripts/config -d SLUB_DEBUG_ON
scripts/config -d PAGE_POISONING
scripts/config -d GDB_SCRIPTS
scripts/config -d ACPI_DEBUG
scripts/config -d PM_DEBUG
scripts/config -d PM_ADVANCED_DEBUG
scripts/config -d PM_SLEEP_DEBUG
scripts/config -d PM_TRACE_RTC
scripts/config -d LATENCYTOP
scripts/config -d LEDS_TRIGGER_CPU
scripts/config -d LEDS_TRIGGER_GPIO
scripts/config -d GENERIC_IRQ_DEBUGFS
scripts/config -d PRINTK_INDEX
scripts/config -d GENERIC_IRQ_STAT_SNAPSHOT
scripts/config -d 6LOWPAN_DEBUGFS
scripts/config -d AF_RXRPC_DEBUG
scripts/config -d AFS_DEBUG
scripts/config -d AFS_DEBUG_CURSOR
scripts/config -d ATA_VERBOSE_ERROR
scripts/config -d ATH10K_DEBUG
scripts/config -d ATH10K_DEBUGFS
scripts/config -d ATH12K_DEBUG
scripts/config -d ATH5K_DEBUG
scripts/config -d ATH6KL_DEBUG
scripts/config -d ATH9K_HTC_DEBUGFS
scripts/config -d ATM_ENI_DEBUG
scripts/config -d ATM_IA_DEBUG
scripts/config -d ATM_IDT77252_DEBUG
scripts/config -d BCACHE_DEBUG
scripts/config -d BCACHEFS_DEBUG
scripts/config -d BEFS_DEBUG
scripts/config -d BLK_DEBUG_FS
scripts/config -d BT_DEBUGFS
scripts/config -d CEPH_LIB_PRETTYDEBUG
scripts/config -d CFG80211_DEBUGFS
scripts/config -d CIFS_DEBUG
scripts/config -d CIFS_DEBUG2
scripts/config -d CIFS_DEBUG_DUMP_KEYS
scripts/config -d CMA_DEBUGFS
scripts/config -d CROS_EC_DEBUGFS
scripts/config -d CRYPTO_DEV_AMLOGIC_GXL_DEBUG
scripts/config -d CRYPTO_DEV_CCP_DEBUGFS
scripts/config -d DEBUG_BOOT_PARAMS
scripts/config -d DEBUG_KMAP_LOCAL_FORCE_MAP
scripts/config -d DEBUG_MEMORY_INIT
scripts/config -d DEBUG_RODATA_TEST
scripts/config -d DEBUG_RSEQ
scripts/config -d DEBUG_SHIRQ
scripts/config -d DEBUG_WX
scripts/config -d DLM_DEBUG
scripts/config -d DM_DEBUG_BLOCK_MANAGER_LOCKING
scripts/config -d DM_DEBUG_BLOCK_STACK_TRACING
scripts/config -d DRM_ACCEL_IVPU_DEBUG
scripts/config -d DRM_DEBUG_DP_MST_TOPOLOGY_REFS
scripts/config -d DRM_DEBUG_MODESET_LOCK
scripts/config -d DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
scripts/config -d DRM_I915_DEBUG
scripts/config -d DRM_I915_DEBUG_GUC
scripts/config -d DRM_I915_DEBUG_MMIO
scripts/config -d DRM_I915_DEBUG_VBLANK_EVADE
scripts/config -d DRM_I915_DEBUG_WAKEREF
scripts/config -d DRM_I915_SW_FENCE_DEBUG_OBJECTS
scripts/config -d DRM_XE_DEBUG
scripts/config -d DRM_XE_DEBUG_MEM
scripts/config -d DRM_XE_DEBUG_MEMIRQ
scripts/config -d DRM_XE_DEBUG_SRIOV
scripts/config -d DRM_XE_DEBUG_VM
scripts/config -d DVB_USB_DEBUG
scripts/config -d EARLY_PRINTK_DBGP
scripts/config -d EARLY_PRINTK_USB_XDBC
scripts/config -d EXT4_DEBUG
scripts/config -d HIST_TRIGGERS_DEBUG
scripts/config -d INFINIBAND_MTHCA_DEBUG
scripts/config -d IWLEGACY_DEBUG
scripts/config -d IWLWIFI_DEBUG
scripts/config -d JFS_DEBUG
scripts/config -d LDM_DEBUG
scripts/config -d LIBERTAS_THINFIRM_DEBUG
scripts/config -d MAC80211_DEBUGFS
scripts/config -d NETFS_DEBUG
scripts/config -d NFS_DEBUG
scripts/config -d NVME_TARGET_DEBUGFS
scripts/config -d NVME_VERBOSE_ERRORS
scripts/config -d OCFS2_DEBUG_FS
scripts/config -d OVMF_DEBUG_LOG
scripts/config -d PNP_DEBUG_MESSAGES
scripts/config -d QUOTA_DEBUG
scripts/config -d RTLWIFI_DEBUG
scripts/config -d RTW88_DEBUG
scripts/config -d RTW88_DEBUGFS
scripts/config -d RTW89_DEBUGFS
scripts/config -d RTW89_DEBUGMSG
scripts/config -d SHRINKER_DEBUG
scripts/config -d SMS_SIANO_DEBUGFS
scripts/config -d SND_SOC_SOF_DEBUG
scripts/config -d SUNRPC_DEBUG
scripts/config -d UFS_DEBUG
scripts/config -d USB_DWC2_DEBUG
scripts/config -d VFIO_DEBUGFS
scripts/config -d VIRTIO_DEBUG
scripts/config -d VISL_DEBUGFS
scripts/config -d WCN36XX_DEBUGFS
scripts/config -d WWAN_DEBUGFS
scripts/config -d XEN_DEBUG_FS
scripts/config -d ZSMALLOC_STAT

### Apply various Clear Linux defaults.
### To skip, uncomment the exit line.

### exit 0

if [[ $(uname -m) = *"x86"* ]]; then
    ### Default to IOMMU passthrough domain type.
    scripts/config -d IOMMU_DEFAULT_DMA_LAZY -e IOMMU_DEFAULT_PASSTHROUGH

    ### Disable support for memory balloon compaction.
    scripts/config -d BALLOON_COMPACTION

    ### Disable the Contiguous Memory Allocator.
    scripts/config -d CMA

    ### Disable DAMON: Data Access Monitoring Framework.
    scripts/config -d DAMON

    ### Disable HWPoison pages injector.
    scripts/config -d HWPOISON_INJECT

    ### Disable track memory changes and idle page tracking.
    scripts/config -d MEM_SOFT_DIRTY -d IDLE_PAGE_TRACKING

    ### Disable paravirtual steal time accounting.
    scripts/config -d PARAVIRT_TIME_ACCOUNTING

    ### Disable khugepaged to put read-only file-backed pages in THP.
    scripts/config -d READ_ONLY_THP_FOR_FS

    ### Disable Integrity Policy Enforcement (IPE).
    scripts/config -d SECURITY_IPE

    ### Disable support for userspace-controlled virtual timers.
    scripts/config -d SND_UTIMER

    ### Disable the general notification queue.
    scripts/config -d WATCH_QUEUE

    ### Disable Watchdog Timer Support.
    scripts/config -d WATCHDOG

    ### Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
    scripts/config -d PCIEASPM_DEFAULT -e PCIEASPM_PERFORMANCE

    ### Disable workqueue power-efficient mode by default.
    scripts/config -d WQ_POWER_EFFICIENT_DEFAULT

    ### Set the default state of memory_corruption_check to off.
    scripts/config -d X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK

    ### Disable Split Lock Detect and Bus Lock Detect support.
    scripts/config -d X86_BUS_LOCK_DETECT

    ### Disable statistic for Change Page Attribute.
    scripts/config -d X86_CPA_STATISTICS

    ### Disable x86 instruction decoder selftest.
    scripts/config -d X86_DECODER_SELFTEST

    ### Disable strong stack protector.
    scripts/config -d STACKPROTECTOR_STRONG -e STACKPROTECTOR

    ### Default to none for vsyscall table for legacy applications.
    scripts/config -d LEGACY_VSYSCALL_XONLY -e LEGACY_VSYSCALL_NONE

    ### Disable LDT (local descriptor table) to run 16-bit or segmented code such as
    ### DOSEMU or some Wine programs. Enabling this adds a small amount of overhead
    ### to context switches and increases the low-level kernel attack surface.
    scripts/config -d UID16 -d X86_16BIT -d MODIFY_LDT_SYSCALL

    ### Disable obsolete sysfs syscall support.
    scripts/config -d SYSFS_SYSCALL

    ### Enforce strict size checking for sigaltstack.
    scripts/config -e STRICT_SIGALTSTACK_SIZE

    ### Disable Kexec and crash features.
    scripts/config -d KEXEC -d KEXEC_FILE -d CRASH_DUMP

    ### Disable low-overhead sampling-based memory safety error detector.
    scripts/config -d KFENCE

    ### Disable utilization clamping for RT/FAIR tasks.
    scripts/config -d UCLAMP_TASK

    ### Disable CGROUP controllers.
    scripts/config -d CGROUP_HUGETLB
    scripts/config -d CGROUP_NET_PRIO
    scripts/config -d CGROUP_PERF
    scripts/config -d CGROUP_RDMA

    ### Disable support for latency based cgroup IO protection.
    scripts/config -d BLK_CGROUP_IOLATENCY

    ### Apply Clear defaults for NR_CPUS and NODES_SHIFT.
    ### Set the other NR_CPUS_* knobs same as NR_CPUS.
    scripts/config -d CPUMASK_OFFSTACK -d MAXSMP
    scripts/config --set-val NR_CPUS_RANGE_BEGIN 512
    scripts/config --set-val NR_CPUS_RANGE_END 512
    scripts/config --set-val NR_CPUS_DEFAULT 512
    scripts/config --set-val NR_CPUS 512
    scripts/config --set-val NODES_SHIFT 10
fi

