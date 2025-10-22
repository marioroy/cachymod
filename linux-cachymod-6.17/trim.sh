#!/bin/bash
# Trim kernel by deselecting options not enabled in the Clear Linux config.
# Options already unset in the CachyOS config were pruned from this list.
# Last checked: 2025-08-01

# Exit immediately on error.
set -e

#
# Processor type and features
#
scripts/config -d XEN
scripts/config -d PVH
scripts/config -d PARAVIRT_TIME_ACCOUNTING

#
# Data Access Monitoring
#
scripts/config -d DAMON

#
# Networking options
#
scripts/config -d SMC_LO
scripts/config -d IP_FIB_TRIE_STATS
scripts/config -d IP_ROUTE_VERBOSE
scripts/config -d NET_IPGRE_BROADCAST
scripts/config -d IP_PIMSM_V1
scripts/config -d IP_PIMSM_V2
scripts/config -d NET_FOU_IP_TUNNELS
scripts/config -d INET_DIAG
scripts/config -d TCP_AO
scripts/config -d INET6_ESPINTCP
scripts/config -d IPV6_SIT_6RD
scripts/config -d IPV6_SUBTREES
scripts/config -d IPV6_MROUTE
scripts/config -d IPV6_SEG6_LWTUNNEL
scripts/config -d IPV6_SEG6_HMAC
scripts/config -d IPV6_RPL_LWTUNNEL
scripts/config -d IPV6_IOAM6_LWTUNNEL

#
# Core Netfilter Configuration
#
scripts/config -d NETFILTER_NETLINK_HOOK
scripts/config -d NF_CONNTRACK_PROCFS
scripts/config -d NF_CONNTRACK_TIMEOUT
scripts/config -d NF_CONNTRACK_TIMESTAMP
scripts/config -d NETFILTER_NETLINK_GLUE_CT

scripts/config -d TIPC_MEDIA_IB
scripts/config -d ATM
scripts/config -d L2TP_V3
scripts/config -d VLAN_8021Q_GVRP
scripts/config -d VLAN_8021Q_MVRP
scripts/config -d LLC2
scripts/config -d ATALK
scripts/config -d PHONET
scripts/config -d 6LOWPAN_DEBUGFS
scripts/config -d IEEE802154_NL802154_EXPERIMENTAL

#
# Classification
#
scripts/config -d CLS_U32_MARK
scripts/config -d GACT_PROB
scripts/config -d NET_ACT_GATE
scripts/config -d NET_TC_SKB_EXT
scripts/config -d BATMAN_ADV_NC
scripts/config -d BATMAN_ADV_MCAST
scripts/config -d HSR
scripts/config -d QRTR_SMD
scripts/config -d QRTR_TUN
scripts/config -d NET_NCSI

#
# Network testing
#
scripts/config -d HAMRADIO
scripts/config -d CAN_ISOTP
scripts/config -d BT_LEDS
scripts/config -d BT_AOSPEXT
scripts/config -d BT_DEBUGFS

#
# Bluetooth device drivers
#
scripts/config -d BT_HCIUART_BCSP
scripts/config -d BT_HCIUART_ATH3K
scripts/config -d BT_HCIUART_LL
scripts/config -d BT_HCIUART_3WIRE
scripts/config -d BT_HCIUART_RTL
scripts/config -d BT_HCIUART_QCA
scripts/config -d BT_HCIUART_AG6XX
scripts/config -d BT_HCIUART_MRVL
scripts/config -d BT_MTKUART
scripts/config -d BT_NXPUART

scripts/config -d AF_RXRPC_IPV6
scripts/config -d AF_RXRPC_DEBUG
scripts/config -d RXKAD
scripts/config -d MCTP
scripts/config -d CFG80211_CERTIFICATION_ONUS
scripts/config -d CFG80211_DEBUGFS
scripts/config -d MAC80211_MESH
scripts/config -d CEPH_LIB_PRETTYDEBUG
scripts/config -d CEPH_LIB_USE_DNS_RESOLVER
scripts/config -d NFC_NCI_SPI
scripts/config -d NFC_NCI_UART
scripts/config -d NFC_SHDLC

#
# Near Field Communication (NFC) devices
#
scripts/config -d NFC_FDP
scripts/config -d NFC_MRVL_I2C
scripts/config -d NFC_ST_NCI_I2C
scripts/config -d NFC_ST_NCI_SPI
scripts/config -d NFC_S3FWRN5_I2C
scripts/config -d NFC_S3FWRN82_UART
scripts/config -d NFC_ST95HF

#
# Device Drivers
#
scripts/config -d PCIEAER_INJECT
scripts/config -d PCIE_ECRC
scripts/config -d PCIE_DPC
scripts/config -d PCI_P2PDMA
scripts/config -d HOTPLUG_PCI_CPCI

scripts/config -d PCCARD

#
# Bus devices
#
scripts/config -d MHI_BUS_PCI_GENERIC

#
# EFI (Extensible Firmware Interface) Support
#
scripts/config -d EFI_CUSTOM_SSDT_OVERLAYS

scripts/config -d GNSS

#
# RAM/ROM/Flash chip drivers
#
scripts/config -d MTD_CFI_BE_BYTE_SWAP
scripts/config -d MTD_CFI_LE_BYTE_SWAP
scripts/config -d MTD_OTP
scripts/config -d MTD_CFI_AMDSTD
scripts/config -d MTD_CFI_STAA
scripts/config -d MTD_ROM
scripts/config -d MTD_SBC_GXX
scripts/config -d MTD_PCI
scripts/config -d MTD_PHRAM
scripts/config -d MTD_MTDRAM
scripts/config -d MTD_NAND_NANDSIM
scripts/config -d MTD_NAND_ECC_SW_HAMMING_SMC
scripts/config -d MTD_NAND_ECC_SW_BCH
scripts/config -d MTD_NAND_ECC_MXIC
scripts/config -d MTD_UBI_NVMEM
scripts/config -d PNP_DEBUG_MESSAGES

#
# Misc devices
#
scripts/config -d AD525X_DPOT
scripts/config -d PHANTOM
scripts/config -d ICS932S401
scripts/config -d HMC6352
scripts/config -d DS1682
scripts/config -d LATTICE_ECP3_CONFIG
scripts/config -d PCI_ENDPOINT_TEST
scripts/config -d XILINX_SDFEC
scripts/config -d TPS6594_ESM
scripts/config -d C2PORT

#
# Texas Instruments shared transport line discipline
#
scripts/config -d TI_ST

scripts/config -d GENWQE
scripts/config -d BCM_VK_TTY
scripts/config -d PVPANIC
scripts/config -d KEBA_CP500

#
# SCSI device support
#
scripts/config -d SCSI_PROC_FS

scripts/config -d SCSI_AIC94XX
scripts/config -d SCSI_MVSAS_TASKLET
scripts/config -d MEGARAID_NEWGEN
scripts/config -d SCSI_FLASHPOINT
scripts/config -d SCSI_PPA
scripts/config -d SCSI_IMM
scripts/config -d QEDI
scripts/config -d QEDF
scripts/config -d SCSI_EFCT
scripts/config -d SCSI_DH

scripts/config -d ATA_VERBOSE_ERROR
scripts/config -d SATA_ZPODD

#
# SATA SFF controllers with BMDMA
#
scripts/config -d SATA_DWC

#
# PATA SFF controllers with BMDMA
#
scripts/config -d PATA_ALI
scripts/config -d PATA_AMD
scripts/config -d PATA_ARTOP
scripts/config -d PATA_ATIIXP
scripts/config -d PATA_ATP867X
scripts/config -d PATA_CMD64X
scripts/config -d PATA_CYPRESS
scripts/config -d PATA_EFAR
scripts/config -d PATA_HPT366
scripts/config -d PATA_HPT37X
scripts/config -d PATA_HPT3X2N
scripts/config -d PATA_HPT3X3
scripts/config -d PATA_IT8213
scripts/config -d PATA_IT821X
scripts/config -d PATA_MARVELL
scripts/config -d PATA_NETCELL
scripts/config -d PATA_NINJA32
scripts/config -d PATA_NS87415
scripts/config -d PATA_OLDPIIX
scripts/config -d PATA_OPTIDMA
scripts/config -d PATA_PDC2027X
scripts/config -d PATA_PDC_OLD
scripts/config -d PATA_RADISYS
scripts/config -d PATA_RDC
scripts/config -d PATA_SERVERWORKS
scripts/config -d PATA_SIL680
scripts/config -d PATA_TOSHIBA
scripts/config -d PATA_TRIFLEX
scripts/config -d PATA_VIA
scripts/config -d PATA_WINBOND

#
# PIO-only SFF controllers
#
scripts/config -d PATA_CMD640_PCI
scripts/config -d PATA_NS87410
scripts/config -d PATA_OPTI
scripts/config -d PATA_RZ1000
scripts/config -d PATA_PARPORT

#
# Generic fallback / legacy drivers
#
scripts/config -d PATA_LEGACY
scripts/config -d MD_AUTODETECT
scripts/config -d MD_CLUSTER
scripts/config -d BCACHE_ASYNC_REGISTRATION
scripts/config -d DM_DEBUG_BLOCK_MANAGER_LOCKING
scripts/config -d DM_EBS
scripts/config -d DM_ERA
scripts/config -d DM_CLONE
scripts/config -d DM_DUST
scripts/config -d DM_INIT
scripts/config -d DM_UEVENT
scripts/config -d DM_VERITY_FEC
scripts/config -d REMOTE_TARGET

#
# IEEE 1394 (FireWire) support
#
scripts/config -d FIREWIRE
scripts/config -d FIREWIRE_NOSY

scripts/config -d MACINTOSH_DRIVERS
scripts/config -d NET_FC
scripts/config -d MHI_NET

#
# Distributed Switch Architecture drivers
#
scripts/config -d NET_DSA_HIRSCHMANN_HELLCREEK
scripts/config -d NET_DSA_MV88E6XXX_PTP
scripts/config -d NET_DSA_AR9331
scripts/config -d NET_DSA_QCA8K_LEDS_SUPPORT
scripts/config -d NET_DSA_SJA1105_TAS
scripts/config -d NET_DSA_VITESSE_VSC73XX_SPI
scripts/config -d NET_DSA_VITESSE_VSC73XX_PLATFORM

scripts/config -d NET_VENDOR_3COM
scripts/config -d NET_VENDOR_ADAPTEC
scripts/config -d NET_VENDOR_ALACRITECH
scripts/config -d NET_VENDOR_ALTEON
scripts/config -d AMD8111_ETH
scripts/config -d AMD_XGBE
scripts/config -d NET_VENDOR_ARC
scripts/config -d SPI_AX88796C_COMPRESSION
scripts/config -d CX_ECAT
scripts/config -d TIGON3_HWMON
scripts/config -d SYSTEMPORT
scripts/config -d BNXT_DCB
scripts/config -d NET_VENDOR_CAVIUM
scripts/config -d CHELSIO_T1_1G
scripts/config -d CHELSIO_T4_DCB
scripts/config -d CRYPTO_DEV_CHELSIO_TLS
scripts/config -d CHELSIO_IPSEC_INLINE
scripts/config -d NET_VENDOR_DEC
scripts/config -d NET_VENDOR_EZCHIP
scripts/config -d IGB_HWMON
scripts/config -d IXGBE_HWMON
scripts/config -d IXGBE_DCB
scripts/config -d PRESTERA
scripts/config -d NET_VENDOR_MICREL
scripts/config -d NET_VENDOR_MICROCHIP
scripts/config -d NET_VENDOR_MICROSEMI
scripts/config -d NET_VENDOR_MYRI
scripts/config -d NET_VENDOR_NATSEMI
scripts/config -d NET_VENDOR_NETERION
scripts/config -d NET_VENDOR_NVIDIA
scripts/config -d NET_VENDOR_OKI
scripts/config -d NET_VENDOR_PENSANDO
scripts/config -d QEDE
scripts/config -d NET_VENDOR_BROCADE
scripts/config -d NET_VENDOR_QUALCOMM
scripts/config -d NET_VENDOR_RDC
scripts/config -d NET_VENDOR_RENESAS
scripts/config -d NET_VENDOR_ROCKER
scripts/config -d NET_VENDOR_SAMSUNG
scripts/config -d NET_VENDOR_SEEQ
scripts/config -d NET_VENDOR_SILAN
scripts/config -d NET_VENDOR_SIS
scripts/config -d SFC_SIENA_SRIOV
scripts/config -d NET_VENDOR_SMSC
scripts/config -d NET_VENDOR_SUN
scripts/config -d NET_VENDOR_SYNOPSYS
scripts/config -d NET_VENDOR_TEHUTI
scripts/config -d NET_VENDOR_TI
scripts/config -d NET_VENDOR_VIA
scripts/config -d NET_VENDOR_WIZNET
scripts/config -d NET_VENDOR_XILINX
scripts/config -d FDDI
scripts/config -d LED_TRIGGER_PHY

#
# MII PHY device drivers
#
scripts/config -d ADIN_PHY
scripts/config -d MARVELL_88X2222_PHY
scripts/config -d MICROCHIP_T1_PHY
scripts/config -d NXP_C45_TJA11XX_PHY
scripts/config -d NXP_TJA11XX_PHY
scripts/config -d DP83TC811_PHY
scripts/config -d DP83867_PHY
scripts/config -d DP83869_PHY
scripts/config -d DP83TD510_PHY
scripts/config -d MICREL_KS8995MA
scripts/config -d CAN_NETLINK
scripts/config -d MDIO_GPIO
scripts/config -d MDIO_MVUSB
scripts/config -d MDIO_MSCC_MIIM
scripts/config -d MDIO_THUNDER

scripts/config -d PPP_FILTER
scripts/config -d PPP_MULTILINK
scripts/config -d SLIP_COMPRESSED
scripts/config -d SLIP_SMART
scripts/config -d SLIP_MODE_SLIP6
scripts/config -d USB_NET_SR9800
scripts/config -d USB_EPSON2888
scripts/config -d USB_KC2190
scripts/config -d ADM8211
scripts/config -d ATH5K_DEBUG
scripts/config -d ATH5K_TRACER
scripts/config -d ATH9K_AHB
scripts/config -d ATH9K_DYNACK
scripts/config -d ATH9K_WOW
scripts/config -d ATH9K_CHANNEL_CONTEXT
scripts/config -d ATH9K_HTC_DEBUGFS
scripts/config -d ATH9K_HWRNG
scripts/config -d ATH6KL_DEBUG
scripts/config -d ATH6KL_TRACING
scripts/config -d ATH10K_DEBUG
scripts/config -d ATH10K_DEBUGFS
scripts/config -d ATH10K_TRACING
scripts/config -d WCN36XX_DEBUGFS
scripts/config -d ATH11K_AHB
scripts/config -d ATH12K_DEBUG
scripts/config -d ATH12K_TRACING
scripts/config -d ATH12K_COREDUMP
scripts/config -d AT76C50X_USB
scripts/config -d BRCM_TRACING
scripts/config -d BRCMDBG

#
# iwl3945 / iwl4965 Debugging Options
#
scripts/config -d IWLEGACY_DEBUG

#
# Debugging Options
#
scripts/config -d IWLWIFI_DEBUG
scripts/config -d IWLWIFI_DEVICE_TRACING

scripts/config -d P54_SPI
scripts/config -d LIBERTAS_SPI
scripts/config -d LIBERTAS_MESH
scripts/config -d LIBERTAS_THINFIRM
scripts/config -d MT7603E
scripts/config -d MT7663S
scripts/config -d WLAN_VENDOR_MICROCHIP
scripts/config -d RTLWIFI_DEBUG
scripts/config -d RTL8XXXU_UNTESTED
scripts/config -d RTW88_DEBUG
scripts/config -d RTW88_DEBUGFS
scripts/config -d RTW89_DEBUGMSG
scripts/config -d RTW89_DEBUGFS
scripts/config -d IEEE802154_HWSIM

#
# Wireless WAN
#
scripts/config -d WWAN_DEBUGFS
scripts/config -d WWAN_HWSIM
scripts/config -d RPMSG_WWAN_CTRL
scripts/config -d IOSM

scripts/config -d NETDEVSIM
scripts/config -d ISDN

#
# Input device support
#
scripts/config -d INPUT_LEDS

#
# Input Device Drivers
#
scripts/config -d KEYBOARD_ADC
scripts/config -d KEYBOARD_ADP5588
scripts/config -d KEYBOARD_ADP5589
scripts/config -d KEYBOARD_QT2160
scripts/config -d KEYBOARD_LKKBD
scripts/config -d KEYBOARD_GPIO_POLLED
scripts/config -d KEYBOARD_TCA6416
scripts/config -d KEYBOARD_TCA8418
scripts/config -d KEYBOARD_MATRIX
scripts/config -d KEYBOARD_LM8333
scripts/config -d KEYBOARD_MAX7359
scripts/config -d KEYBOARD_MPR121
scripts/config -d KEYBOARD_NEWTON
scripts/config -d KEYBOARD_OPENCORES
scripts/config -d KEYBOARD_SAMSUNG
scripts/config -d KEYBOARD_STOWAWAY
scripts/config -d KEYBOARD_SUNKBD
scripts/config -d KEYBOARD_XTKBD
scripts/config -d MOUSE_PS2_BYD
scripts/config -d MOUSE_PS2_SENTELIC
scripts/config -d MOUSE_PS2_TOUCHKIT
scripts/config -d MOUSE_GPIO
scripts/config -d JOYSTICK_A3D
scripts/config -d JOYSTICK_ADC
scripts/config -d JOYSTICK_ADI
scripts/config -d JOYSTICK_COBRA
scripts/config -d JOYSTICK_GF2K
scripts/config -d JOYSTICK_GRIP
scripts/config -d JOYSTICK_GRIP_MP
scripts/config -d JOYSTICK_GUILLEMOT
scripts/config -d JOYSTICK_INTERACT
scripts/config -d JOYSTICK_SIDEWINDER
scripts/config -d JOYSTICK_TMDC
scripts/config -d JOYSTICK_IFORCE
scripts/config -d JOYSTICK_WARRIOR
scripts/config -d JOYSTICK_MAGELLAN
scripts/config -d JOYSTICK_SPACEORB
scripts/config -d JOYSTICK_SPACEBALL
scripts/config -d JOYSTICK_STINGER
scripts/config -d JOYSTICK_TWIDJOY
scripts/config -d JOYSTICK_ZHENHUA
scripts/config -d JOYSTICK_DB9
scripts/config -d JOYSTICK_GAMECON
scripts/config -d JOYSTICK_TURBOGRAFX
scripts/config -d JOYSTICK_AS5011
scripts/config -d JOYSTICK_JOYDUMP
scripts/config -d JOYSTICK_WALKERA0701
scripts/config -d JOYSTICK_PSXPAD_SPI
scripts/config -d JOYSTICK_PXRC
scripts/config -d JOYSTICK_QWIIC
scripts/config -d JOYSTICK_FSIA6B
scripts/config -d JOYSTICK_SEESAW
scripts/config -d INPUT_TABLET
scripts/config -d TOUCHSCREEN_CY8CTMA140
scripts/config -d TOUCHSCREEN_ILITEK
scripts/config -d TOUCHSCREEN_MSG2638
scripts/config -d TOUCHSCREEN_TSC2007_IIO
scripts/config -d TOUCHSCREEN_ZINITIX
scripts/config -d INPUT_AD714X
scripts/config -d INPUT_BMA150
scripts/config -d INPUT_MMA8450
scripts/config -d INPUT_GPIO_BEEPER
scripts/config -d INPUT_GPIO_DECODER
scripts/config -d INPUT_GPIO_VIBRA
scripts/config -d INPUT_REGULATOR_HAPTIC
scripts/config -d INPUT_PCF8574
scripts/config -d INPUT_PWM_BEEPER
scripts/config -d INPUT_ADXL34X
scripts/config -d INPUT_IMS_PCU
scripts/config -d INPUT_IQS269A
scripts/config -d INPUT_IQS626A
scripts/config -d INPUT_DRV260X_HAPTICS
scripts/config -d INPUT_DRV2665_HAPTICS
scripts/config -d INPUT_DRV2667_HAPTICS
scripts/config -d RMI4_F34

#
# Hardware I/O ports
#
scripts/config -d SERIO_CT82C710
scripts/config -d SERIO_PARKBD
scripts/config -d SERIO_PCIPS2
scripts/config -d SERIO_PS2MULT
scripts/config -d USERIO

#
# Serial drivers
#
scripts/config -d SERIAL_8250_EXTENDED
scripts/config -d SERIAL_8250_DFL
scripts/config -d SERIAL_8250_RT288X
scripts/config -d SERIAL_8250_MID

#
# Non-8250 serial port support
#
scripts/config -d SERIAL_MAX3100
scripts/config -d SERIAL_MAX310X
scripts/config -d SERIAL_UARTLITE
scripts/config -d SERIAL_SCCNXP
scripts/config -d SERIAL_SC16IS7XX
scripts/config -d SERIAL_ALTERA_JTAGUART
scripts/config -d SERIAL_ALTERA_UART
scripts/config -d SERIAL_RP2
scripts/config -d SERIAL_FSL_LPUART
scripts/config -d SERIAL_FSL_LINFLEXUART
scripts/config -d SERIAL_SPRD

scripts/config -d SERIAL_NONSTANDARD
scripts/config -d RPMSG_TTY
scripts/config -d LP_CONSOLE
scripts/config -d HW_RANDOM_BA431
scripts/config -d HW_RANDOM_VIA
scripts/config -d HW_RANDOM_XIPHERA
scripts/config -d APPLICOM
scripts/config -d TCG_VTPM_PROXY
scripts/config -d TCG_TIS_ST33ZP24_SPI
scripts/config -d XILLYUSB

#
# PC SMBus host controller drivers
#
scripts/config -d I2C_ALI1535
scripts/config -d I2C_ALI1563
scripts/config -d I2C_ALI15X3
scripts/config -d I2C_SIS5595
scripts/config -d I2C_SIS630
scripts/config -d I2C_ZHAOXIN

#
# ACPI drivers
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
scripts/config -d I2C_CBUS_GPIO
scripts/config -d I2C_EMEV2
scripts/config -d I2C_GPIO
scripts/config -d I2C_OCORES

#
# External I2C/SMBus adapter drivers
#
scripts/config -d I2C_CP2615
scripts/config -d I2C_ROBOTFUZZ_OSIF
scripts/config -d I2C_TAOS_EVM

scripts/config -d I2C_SLAVE_TESTUNIT

#
# SPI Master Controller Drivers
#
scripts/config -d SPI_ALTERA_DFL
scripts/config -d SPI_AXI_SPI_ENGINE
scripts/config -d SPI_BUTTERFLY
scripts/config -d SPI_DW_DMA
scripts/config -d SPI_GPIO
scripts/config -d SPI_INTEL_PCI
scripts/config -d SPI_INTEL_PLATFORM
scripts/config -d SPI_LM70_LLP
scripts/config -d SPI_OC_TINY
scripts/config -d SPI_SIFIVE
scripts/config -d SPI_ZYNQMP_GQSPI

#
# SPI Protocol Masters
#
scripts/config -d SPI_SPIDEV
scripts/config -d SPI_LOOPBACK_TEST
scripts/config -d SPI_TLE62X0
scripts/config -d SPI_SLAVE

#
# PPS clients support
#
scripts/config -d PPS_CLIENT_KTIMER

#
# PTP clock support
#
scripts/config -d PTP_1588_CLOCK_KVM
scripts/config -d PTP_DFL_TOD

scripts/config -d PINCTRL_MCP23S08
scripts/config -d PINCTRL_SX150X

scripts/config -d GPIO_SYSFS

#
# Memory mapped GPIO drivers
#
scripts/config -d GPIO_DWAPB
scripts/config -d GPIO_GENERIC_PLATFORM
scripts/config -d GPIO_MB86S7X
scripts/config -d GPIO_AMD_FCH

#
# Port-mapped I/O GPIO drivers
#
scripts/config -d GPIO_VX855
scripts/config -d GPIO_F7188X
scripts/config -d GPIO_SCH
scripts/config -d GPIO_SCH311X
scripts/config -d GPIO_WINBOND
scripts/config -d GPIO_WS16C48

#
# I2C GPIO expanders
#
scripts/config -d GPIO_MAX7300
scripts/config -d GPIO_MAX732X
scripts/config -d GPIO_PCA953X
scripts/config -d GPIO_PCF857X
scripts/config -d GPIO_TPIC2810

#
# MFD GPIO expanders
#
scripts/config -d GPIO_ELKHARTLAKE
scripts/config -d GPIO_TPS68470

#
# PCI GPIO expanders
#
scripts/config -d GPIO_AMD8111
scripts/config -d GPIO_ML_IOH
scripts/config -d GPIO_PCIE_IDIO_24
scripts/config -d GPIO_RDC321X

#
# SPI GPIO expanders
#
scripts/config -d GPIO_MAX3191X
scripts/config -d GPIO_MAX7301
scripts/config -d GPIO_MC33880
scripts/config -d GPIO_PISOSR
scripts/config -d GPIO_XRA1403

#
# Virtual GPIO drivers
#
scripts/config -d GPIO_AGGREGATOR
scripts/config -d GPIO_MOCKUP

#
# GPIO Debugging utilities
#
scripts/config -d GPIO_SLOPPY_LOGIC_ANALYZER

#
# 1-wire Bus Masters
#
scripts/config -d W1_MASTER_MATROX
scripts/config -d W1_MASTER_GPIO
scripts/config -d W1_MASTER_SGI
scripts/config -d W1_MASTER_UART

#
# 1-wire Slaves
#
scripts/config -d W1_SLAVE_DS250X
scripts/config -d W1_SLAVE_DS28E17

scripts/config -d POWER_RESET
scripts/config -d POWER_SEQUENCING
scripts/config -d GENERIC_ADC_BATTERY
scripts/config -d TEST_POWER
scripts/config -d CHARGER_ADP5061
scripts/config -d BATTERY_CW2015
scripts/config -d BATTERY_DS2760
scripts/config -d BATTERY_DS2780
scripts/config -d BATTERY_DS2781
scripts/config -d BATTERY_DS2782
scripts/config -d BATTERY_SBS
scripts/config -d CHARGER_SBS
scripts/config -d BATTERY_BQ27XXX
scripts/config -d BATTERY_MAX17040
scripts/config -d BATTERY_MAX1720X
scripts/config -d BATTERY_MAX1721X
scripts/config -d CHARGER_ISP1704
scripts/config -d CHARGER_MAX8903
scripts/config -d CHARGER_LP8727
scripts/config -d CHARGER_GPIO
scripts/config -d CHARGER_MANAGER
scripts/config -d CHARGER_LT3651
scripts/config -d CHARGER_BQ2415X
scripts/config -d CHARGER_BQ24257
scripts/config -d CHARGER_BQ24735
scripts/config -d CHARGER_BQ2515X
scripts/config -d CHARGER_BQ25890
scripts/config -d CHARGER_BQ25980
scripts/config -d CHARGER_BQ256XX
scripts/config -d BATTERY_GAUGE_LTC2941
scripts/config -d BATTERY_RT5033
scripts/config -d CHARGER_RT9455
scripts/config -d CHARGER_RT9471
scripts/config -d CHARGER_BD99954
scripts/config -d CHARGER_WILCO
scripts/config -d BATTERY_UG3105
scripts/config -d FUEL_GAUGE_MM8013

#
# Native drivers
#
scripts/config -d SENSORS_CORSAIR_CPRO
scripts/config -d SENSORS_CORSAIR_PSU
scripts/config -d I8K
scripts/config -d SENSORS_HIH6130
scripts/config -d SENSORS_IIO_HWMON
scripts/config -d SENSORS_LTC2992
scripts/config -d SENSORS_MAX127
scripts/config -d SENSORS_MAX6621
scripts/config -d SENSORS_TPS23861
scripts/config -d SENSORS_MR75203
scripts/config -d SENSORS_NZXT_KRAKEN2
scripts/config -d SENSORS_ADM1266
scripts/config -d SENSORS_BPA_RS600
scripts/config -d SENSORS_FSP_3Y
scripts/config -d SENSORS_IBM_CFFPS
scripts/config -d SENSORS_DPS920AB
scripts/config -d SENSORS_INA233
scripts/config -d SENSORS_INSPUR_IPSPS
scripts/config -d SENSORS_IR35221
scripts/config -d SENSORS_IR36021
scripts/config -d SENSORS_IR38064
scripts/config -d SENSORS_IRPS5401
scripts/config -d SENSORS_ISL68137
scripts/config -d SENSORS_LM25066_REGULATOR
scripts/config -d SENSORS_LTC4286
scripts/config -d SENSORS_MAX15301
scripts/config -d SENSORS_MAX16601
scripts/config -d SENSORS_MAX31785
scripts/config -d SENSORS_MP2856
scripts/config -d SENSORS_MP2888
scripts/config -d SENSORS_MP2891
scripts/config -d SENSORS_MP2975
scripts/config -d SENSORS_MP2993
scripts/config -d SENSORS_MP5920
scripts/config -d SENSORS_MP5990
scripts/config -d SENSORS_MP9941
scripts/config -d SENSORS_MPQ7932_REGULATOR
scripts/config -d SENSORS_PIM4328
scripts/config -d SENSORS_PLI1209BC_REGULATOR
scripts/config -d SENSORS_PM6764TR
scripts/config -d SENSORS_PXE1610
scripts/config -d SENSORS_Q54SJ108A2
scripts/config -d SENSORS_STPDDC60
scripts/config -d SENSORS_TDA38640_REGULATOR
scripts/config -d SENSORS_XDPE122_REGULATOR
scripts/config -d SENSORS_SBTSI
scripts/config -d SENSORS_SHT4x
scripts/config -d SENSORS_EMC2103
scripts/config -d SENSORS_STTS751
scripts/config -d SENSORS_SPD5118_DETECT
scripts/config -d SENSORS_XGENE

#
# ACPI drivers
#
scripts/config -d THERMAL_GOV_POWER_ALLOCATOR
scripts/config -d DEVFREQ_THERMAL

scripts/config -d GENERIC_ADC_THERMAL
scripts/config -d WATCHDOG
scripts/config -d SSB_DRIVER_GPIO
scripts/config -d BCMA_DRIVER_GMAC_CMN
scripts/config -d BCMA_DRIVER_GPIO

#
# Multifunction device drivers
#
scripts/config -d MFD_AS3711
scripts/config -d MFD_SMPRO
scripts/config -d PMIC_ADP5520
scripts/config -d MFD_AAT2870_CORE
scripts/config -d MFD_AXP20X_I2C
scripts/config -d MFD_MADERA
scripts/config -d PMIC_DA903X
scripts/config -d MFD_DA9052_SPI
scripts/config -d MFD_DA9052_I2C
scripts/config -d MFD_DA9055
scripts/config -d MFD_DA9062
scripts/config -d MFD_DA9063
scripts/config -d MFD_DA9150
scripts/config -d MFD_DLN2
scripts/config -d MFD_MC13XXX_SPI
scripts/config -d MFD_MC13XXX_I2C
scripts/config -d MFD_MP2629
scripts/config -d MFD_IQS62X
scripts/config -d MFD_JANZ_CMODIO
scripts/config -d MFD_KEMPLD
scripts/config -d MFD_88PM800
scripts/config -d MFD_88PM805
scripts/config -d MFD_88PM860X
scripts/config -d MFD_MAX14577
scripts/config -d MFD_MAX77693
scripts/config -d MFD_MAX77705
scripts/config -d MFD_MAX77843
scripts/config -d MFD_MAX8907
scripts/config -d MFD_MAX8925
scripts/config -d MFD_MAX8997
scripts/config -d MFD_MAX8998
scripts/config -d MFD_MT6360
scripts/config -d MFD_MT6397
scripts/config -d MFD_MENF21BMC
scripts/config -d EZX_PCAP
scripts/config -d MFD_RETU
scripts/config -d MFD_PCF50633
scripts/config -d MFD_QNAP_MCU
scripts/config -d MFD_RDC321X
scripts/config -d MFD_RT4831
scripts/config -d MFD_RT5033
scripts/config -d MFD_RC5T583
scripts/config -d MFD_SI476X_CORE
scripts/config -d MFD_SM501_GPIO
scripts/config -d MFD_SKY81452
scripts/config -d MFD_LP3943
scripts/config -d MFD_LP8788
scripts/config -d MFD_TI_LMU
scripts/config -d MFD_PALMAS
scripts/config -d TPS6105X
scripts/config -d TPS65010
scripts/config -d TPS6507X
scripts/config -d MFD_TPS65086
scripts/config -d MFD_TPS65090
scripts/config -d MFD_TI_LP873X
scripts/config -d MFD_TPS6586X
scripts/config -d MFD_TPS65910
scripts/config -d MFD_TPS65912_I2C
scripts/config -d MFD_TPS65912_SPI
scripts/config -d MFD_TPS6594_SPI
scripts/config -d TWL4030_CORE
scripts/config -d TWL6040_CORE
scripts/config -d MFD_LM3533
scripts/config -d MFD_TQMX86
scripts/config -d MFD_ARIZONA_I2C
scripts/config -d MFD_ARIZONA_SPI
scripts/config -d MFD_WM8400
scripts/config -d MFD_WM831X_I2C
scripts/config -d MFD_WM831X_SPI
scripts/config -d MFD_WM8350_I2C
scripts/config -d MFD_WM8994
scripts/config -d MFD_ATC260X_I2C
scripts/config -d RAVE_SP_CORE

scripts/config -d REGULATOR_FIXED_VOLTAGE
scripts/config -d REGULATOR_VIRTUAL_CONSUMER
scripts/config -d REGULATOR_USERSPACE_CONSUMER
scripts/config -d REGULATOR_NETLINK_EVENTS
scripts/config -d REGULATOR_88PG86X
scripts/config -d REGULATOR_ACT8865
scripts/config -d REGULATOR_AD5398
scripts/config -d REGULATOR_BCM590XX
scripts/config -d REGULATOR_BD9571MWV
scripts/config -d REGULATOR_DA9210
scripts/config -d REGULATOR_DA9211
scripts/config -d REGULATOR_FAN53555
scripts/config -d REGULATOR_GPIO
scripts/config -d REGULATOR_ISL9305
scripts/config -d REGULATOR_ISL6271A
scripts/config -d REGULATOR_LP3971
scripts/config -d REGULATOR_LP3972
scripts/config -d REGULATOR_LP872X
scripts/config -d REGULATOR_LP8755
scripts/config -d REGULATOR_LTC3589
scripts/config -d REGULATOR_LTC3676
scripts/config -d REGULATOR_MAX1586
scripts/config -d REGULATOR_MAX77541
scripts/config -d REGULATOR_MAX8649
scripts/config -d REGULATOR_MAX8660
scripts/config -d REGULATOR_MAX8893
scripts/config -d REGULATOR_MAX8952
scripts/config -d REGULATOR_MAX77826
scripts/config -d REGULATOR_MT6311
scripts/config -d REGULATOR_PCA9450
scripts/config -d REGULATOR_PF9453
scripts/config -d REGULATOR_PV88060
scripts/config -d REGULATOR_PV88080
scripts/config -d REGULATOR_PV88090
scripts/config -d REGULATOR_PWM
scripts/config -d REGULATOR_RAA215300
scripts/config -d REGULATOR_RT4801
scripts/config -d REGULATOR_RT6160
scripts/config -d REGULATOR_RT6245
scripts/config -d REGULATOR_RTMV20
scripts/config -d REGULATOR_SLG51000
scripts/config -d REGULATOR_TPS51632
scripts/config -d REGULATOR_TPS62360
scripts/config -d REGULATOR_TPS65023
scripts/config -d REGULATOR_TPS6507X
scripts/config -d REGULATOR_TPS65132
scripts/config -d REGULATOR_TPS6524X
scripts/config -d IR_RCMM_DECODER
scripts/config -d IR_SERIAL_TRANSMITTER
scripts/config -d IR_TOY

#
# CEC support
#
scripts/config -d CEC_SECO_RC
scripts/config -d USB_PULSE8_CEC
scripts/config -d USB_RAINSHADOW_CEC

scripts/config -d MEDIA_SUPPORT_FILTER

#
# Analog TV USB devices
#
scripts/config -d VIDEO_GO7007_USB_S2250_BOARD

#
# Analog/digital TV USB devices
#
scripts/config -d VIDEO_AU0828_RC

#
# Digital TV USB devices
#
scripts/config -d DVB_USB_LME2510
scripts/config -d DVB_USB

#
# Software defined radio USB devices
#
scripts/config -d USB_MSI2500

#
# Media capture support
#
scripts/config -d VIDEO_ZORAN_DC30
scripts/config -d VIDEO_ZORAN_BUZ

#
# Media capture/analog TV support
#
scripts/config -d VIDEO_FB_IVTV_FORCE_PAT

#
# Media capture/analog/hybrid TV support
#
scripts/config -d VIDEO_COBALT

#
# Media digital TV PCI Adapters
#
scripts/config -d DVB_NETUP_UNIDVB
scripts/config -d RADIO_TEF6862
scripts/config -d USB_RAREMONO
scripts/config -d USB_SI4713
scripts/config -d PLATFORM_SI4713
scripts/config -d I2C_SI4713
scripts/config -d SDR_PLATFORM_DRIVERS
scripts/config -d DVB_PLATFORM_DRIVERS
scripts/config -d V4L_MEM2MEM_DRIVERS

#
# Cadence media platform drivers
#
scripts/config -d VIDEO_CADENCE_CSI2RX
scripts/config -d VIDEO_CADENCE_CSI2TX

#
# Marvell media platform drivers
#
scripts/config -d VIDEO_CAFE_CCIC

#
# MMC/SDIO DVB adapters
#
scripts/config -d SMS_SDIO_DRV
scripts/config -d V4L_TEST_DRIVERS
scripts/config -d DVB_TEST_DRIVERS

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
scripts/config -d VIDEO_IMX208
scripts/config -d VIDEO_OV2740
scripts/config -d VIDEO_RDACM21
scripts/config -d VIDEO_CCS

#
# Lens drivers
#
scripts/config -d VIDEO_AD5820
scripts/config -d VIDEO_AK7375
scripts/config -d VIDEO_DW9714
scripts/config -d VIDEO_DW9719
scripts/config -d VIDEO_DW9768
scripts/config -d VIDEO_DW9807_VCM

#
# Flash devices
#
scripts/config -d VIDEO_ADP1653
scripts/config -d VIDEO_LM3560
scripts/config -d VIDEO_LM3646

#
# Audio decoders, processors and mixers
#
scripts/config -d VIDEO_TDA1997X
scripts/config -d VIDEO_TLV320AIC23B

#
# SDR tuner chips
#
scripts/config -d SDR_MAX2175

#
# Miscellaneous helper chips
#
scripts/config -d VIDEO_I2C
scripts/config -d VIDEO_ST_MIPID02
scripts/config -d VIDEO_THS7303

#
# Media SPI Adapters
#
scripts/config -d CXD2880_SPI_DRV
scripts/config -d VIDEO_GS1662

#
# Customize TV tuners
#
scripts/config -d MEDIA_TUNER_MSI001
scripts/config -d MEDIA_TUNER_TDA18250

#
# Graphics support
#
scripts/config -d DRM_DEBUG_DP_MST_TOPOLOGY_REFS
scripts/config -d DRM_DEBUG_MODESET_LOCK
scripts/config -d DRM_FBDEV_LEAK_PHYS_SMEM
scripts/config -d DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG

#
# I2C encoder or helper chips
#
scripts/config -d DRM_I2C_NXP_TDA9950

#
# drm/i915 Debugging
#
scripts/config -d DRM_I915_WERROR
scripts/config -d DRM_I915_REPLAY_GPU_HANGS_API
scripts/config -d DRM_I915_DEBUG
scripts/config -d DRM_I915_DEBUG_MMIO
scripts/config -d DRM_I915_SW_FENCE_DEBUG_OBJECTS
scripts/config -d DRM_I915_SW_FENCE_CHECK_DAG
scripts/config -d DRM_I915_DEBUG_GUC
scripts/config -d DRM_I915_SELFTEST
scripts/config -d DRM_I915_DEBUG_VBLANK_EVADE
scripts/config -d DRM_I915_DEBUG_WAKEREF

#
# drm/Xe Debugging
#
scripts/config -d DRM_XE_WERROR
scripts/config -d DRM_XE_DEBUG
scripts/config -d DRM_XE_DEBUG_VM
scripts/config -d DRM_XE_DEBUG_SRIOV
scripts/config -d DRM_XE_DEBUG_MEM
scripts/config -d DRM_XE_USERPTR_INVAL_INJECT

scripts/config -d DRM_VKMS
scripts/config -d DRM_GMA500

#
# Backlight & LCD device support
#
scripts/config -d LCD_L4F00242T03
scripts/config -d LCD_LMS283GF05
scripts/config -d LCD_LTV350QV
scripts/config -d LCD_ILI922X
scripts/config -d LCD_ILI9320
scripts/config -d LCD_TDO24M
scripts/config -d LCD_VGG2432A4
scripts/config -d LCD_AMS369FG06
scripts/config -d LCD_LMS501KF03
scripts/config -d LCD_HX8357
scripts/config -d LCD_OTM3225A
scripts/config -d BACKLIGHT_KTD253
scripts/config -d BACKLIGHT_SAHARA
scripts/config -d BACKLIGHT_ADP8860
scripts/config -d BACKLIGHT_ADP8870
scripts/config -d BACKLIGHT_LM3630A
scripts/config -d BACKLIGHT_LM3639
scripts/config -d BACKLIGHT_GPIO
scripts/config -d BACKLIGHT_LV5207LP
scripts/config -d BACKLIGHT_BD6107

scripts/config -d SND_UMP_LEGACY_RAWMIDI
scripts/config -d SND_SEQ_UMP
scripts/config -d SND_DUMMY
scripts/config -d SND_PCMTEST
scripts/config -d SND_MTPAV
scripts/config -d SND_MTS64
scripts/config -d SND_SERIAL_U16550
scripts/config -d SND_MPU401
scripts/config -d SND_PORTMAN2X4
scripts/config -d SND_AW2
scripts/config -d SND_ES1968_INPUT
scripts/config -d SND_ES1968_RADIO
scripts/config -d SND_FM801_TEA575X_BOOL
scripts/config -d SND_MAESTRO3_INPUT

#
# HD-Audio
#
scripts/config -d SND_HDA_INPUT_BEEP

scripts/config -d SND_SPI
scripts/config -d SND_USB_CAIAQ_INPUT
scripts/config -d SND_SOC_AMD_RV_RT5682_MACH
scripts/config -d SND_SOC_AMD_LEGACY_MACH
scripts/config -d SND_ATMEL_SOC
scripts/config -d SND_DESIGNWARE_PCM

scripts/config -d SND_SOC_IMG

scripts/config -d SND_SOC_INTEL_SOF_CS42L42_MACH
scripts/config -d SND_SOC_SOF_NOCODEC_SUPPORT
scripts/config -d SND_SOC_SOF_STRICT_ABI_CHECKS
scripts/config -d SND_SOC_SOF_DEBUG
scripts/config -d SND_SOC_SOF_AMD_RENOIR

scripts/config -d SND_SOC_XILINX_I2S
scripts/config -d SND_SOC_XILINX_AUDIO_FORMATTER
scripts/config -d SND_SOC_XILINX_SPDIF
scripts/config -d SND_SOC_XTFPGA_I2S

#
# CODEC drivers
#
scripts/config -d SND_SOC_ADAU1701
scripts/config -d SND_SOC_AK4104
scripts/config -d SND_SOC_AK4118
scripts/config -d SND_SOC_AK4554
scripts/config -d SND_SOC_AK4613
scripts/config -d SND_SOC_AK4642
scripts/config -d SND_SOC_AK5386
scripts/config -d SND_SOC_ALC5623
scripts/config -d SND_SOC_CS35L32
scripts/config -d SND_SOC_CS35L33
scripts/config -d SND_SOC_CS35L36
scripts/config -d SND_SOC_CS42L51_I2C
scripts/config -d SND_SOC_CS42L52
scripts/config -d SND_SOC_CS42L56
scripts/config -d SND_SOC_CS42L73
scripts/config -d SND_SOC_CS4234
scripts/config -d SND_SOC_CS4265
scripts/config -d SND_SOC_CS4270
scripts/config -d SND_SOC_CS4271_I2C
scripts/config -d SND_SOC_CS4271_SPI
scripts/config -d SND_SOC_CS42XX8_I2C
scripts/config -d SND_SOC_CS4341
scripts/config -d SND_SOC_CS4349
scripts/config -d SND_SOC_CS53L30
scripts/config -d SND_SOC_ES7241
scripts/config -d SND_SOC_ES8311
scripts/config -d SND_SOC_GTM601
scripts/config -d SND_SOC_MAX98504
scripts/config -d SND_SOC_MAX9860
scripts/config -d SND_SOC_MSM8916_WCD_DIGITAL
scripts/config -d SND_SOC_PCM1681
scripts/config -d SND_SOC_PCM179X_I2C
scripts/config -d SND_SOC_PCM179X_SPI
scripts/config -d SND_SOC_PCM3168A_SPI
scripts/config -d SND_SOC_PCM5102A
scripts/config -d SND_SOC_PCM512x_SPI
scripts/config -d SND_SOC_RT5616
scripts/config -d SND_SOC_RT5631
scripts/config -d SND_SOC_RT5659
scripts/config -d SND_SOC_SGTL5000
scripts/config -d SND_SOC_SSM2305
scripts/config -d SND_SOC_SSM2518
scripts/config -d SND_SOC_SSM2602_SPI
scripts/config -d SND_SOC_SSM2602_I2C
scripts/config -d SND_SOC_STA32X
scripts/config -d SND_SOC_STA350
scripts/config -d SND_SOC_STI_SAS
scripts/config -d SND_SOC_TAS2552
scripts/config -d SND_SOC_TAS2562
scripts/config -d SND_SOC_TAS2764
scripts/config -d SND_SOC_TAS2770
scripts/config -d SND_SOC_TAS5086
scripts/config -d SND_SOC_TAS571X
scripts/config -d SND_SOC_TAS5720
scripts/config -d SND_SOC_TFA9879
scripts/config -d SND_SOC_TFA989X
scripts/config -d SND_SOC_TLV320AIC23_I2C
scripts/config -d SND_SOC_TLV320AIC23_SPI
scripts/config -d SND_SOC_TLV320AIC31XX
scripts/config -d SND_SOC_TLV320AIC3X_I2C
scripts/config -d SND_SOC_TLV320AIC3X_SPI
scripts/config -d SND_SOC_TLV320ADCX140
scripts/config -d SND_SOC_TSCS454
scripts/config -d SND_SOC_WM8510
scripts/config -d SND_SOC_WM8523
scripts/config -d SND_SOC_WM8580
scripts/config -d SND_SOC_WM8711
scripts/config -d SND_SOC_WM8728
scripts/config -d SND_SOC_WM8737
scripts/config -d SND_SOC_WM8741
scripts/config -d SND_SOC_WM8750
scripts/config -d SND_SOC_WM8753
scripts/config -d SND_SOC_WM8770
scripts/config -d SND_SOC_WM8776
scripts/config -d SND_SOC_WM8782
scripts/config -d SND_SOC_WM8804_SPI
scripts/config -d SND_SOC_WM8903
scripts/config -d SND_SOC_WM8904
scripts/config -d SND_SOC_WM8960
scripts/config -d SND_SOC_WM8962
scripts/config -d SND_SOC_WM8974
scripts/config -d SND_SOC_WM8978
scripts/config -d SND_SOC_WM8985
scripts/config -d SND_SOC_MT6351
scripts/config -d SND_SOC_MT6358
scripts/config -d SND_SOC_MT6660
scripts/config -d SND_SOC_NAU8810
scripts/config -d SND_SOC_TPA6130A2
scripts/config -d SND_SOC_LPASS_WSA_MACRO
scripts/config -d SND_SOC_LPASS_VA_MACRO
scripts/config -d SND_SOC_LPASS_RX_MACRO
scripts/config -d SND_SOC_LPASS_TX_MACRO

#
# Special HID drivers
#
scripts/config -d HID_ACRUX_FF
scripts/config -d HID_MACALLY
scripts/config -d DRAGONRISE_FF
scripts/config -d HID_FT260
scripts/config -d HOLTEK_FF
scripts/config -d HID_VIEWSONIC
scripts/config -d LOGIRUMBLEPAD2_FF
scripts/config -d LOGIG940_FF
scripts/config -d HID_MALTRON
scripts/config -d NINTENDO_FF
scripts/config -d NVIDIA_SHIELD_FF
scripts/config -d PANTHERLORD_FF
scripts/config -d HID_PICOLCD_FB
scripts/config -d HID_PICOLCD_BACKLIGHT
scripts/config -d HID_PICOLCD_LCD
scripts/config -d HID_PICOLCD_LEDS
scripts/config -d HID_PICOLCD_CIR
scripts/config -d SONY_FF
scripts/config -d STEAM_FF
scripts/config -d GREENASIA_FF
scripts/config -d SMARTJOYPLUS_FF
scripts/config -d HID_TOPRE
scripts/config -d THRUSTMASTER_FF
scripts/config -d ZEROPLUS_FF

scripts/config -d USB_LED_TRIG

#
# Miscellaneous USB options
#
scripts/config -d USB_OTG_DISABLE_EXTERNAL_HUB

#
# USB Host Controller Drivers
#
scripts/config -d USB_C67X00_HCD
scripts/config -d USB_XHCI_DBGCAP
scripts/config -d USB_EHCI_FSL
scripts/config -d USB_OXU210HP_HCD
scripts/config -d USB_ISP116X_HCD
scripts/config -d USB_R8A66597_HCD
scripts/config -d USB_HCD_SSB

#
# USB Imaging devices
#
scripts/config -d USBIP_VUDC

#
# USB dual-mode controller drivers
#
scripts/config -d USB_CDNS3_GADGET
scripts/config -d USB_CDNS3_HOST
scripts/config -d USB_CDNSP_PCI
scripts/config -d USB_MUSB_HDRC
scripts/config -d USB_DWC3
scripts/config -d USB_DWC2
scripts/config -d USB_CHIPIDEA
scripts/config -d USB_ISP1760

#
# USB Miscellaneous drivers
#
scripts/config -d USB_CYPRESS_CY7C63
scripts/config -d USB_CYTHERM
scripts/config -d USB_TEST
scripts/config -d USB_EHSET_TEST_FIXTURE
scripts/config -d USB_LINK_LAYER_TEST

#
# USB Physical Layer drivers
#
scripts/config -d USB_GPIO_VBUS
scripts/config -d USB_ISP1301

#
# USB Peripheral Controller
#
scripts/config -d USB_GR_UDC
scripts/config -d USB_R8A66597
scripts/config -d USB_PXA27X
scripts/config -d USB_MV_UDC
scripts/config -d USB_MV_U3D
scripts/config -d USB_M66592
scripts/config -d USB_BDC_UDC
scripts/config -d USB_AMD5536UDC
scripts/config -d USB_NET2272
scripts/config -d USB_NET2280
scripts/config -d USB_GOKU
scripts/config -d USB_EG20T
scripts/config -d USB_DUMMY_HCD

scripts/config -d USB_CONFIGFS

#
# USB Gadget precomposed configurations
#
scripts/config -d USB_ZERO
scripts/config -d USB_ETH
scripts/config -d USB_G_NCM
scripts/config -d USB_GADGETFS
scripts/config -d USB_FUNCTIONFS
scripts/config -d USB_MASS_STORAGE
scripts/config -d USB_GADGET_TARGET
scripts/config -d USB_G_SERIAL
scripts/config -d USB_MIDI_GADGET
scripts/config -d USB_G_PRINTER
scripts/config -d USB_CDC_COMPOSITE
scripts/config -d USB_G_ACM_MS
scripts/config -d USB_G_MULTI
scripts/config -d USB_G_DBGP
scripts/config -d USB_G_WEBCAM

scripts/config -d TYPEC_TCPCI_MAXIM
scripts/config -d TYPEC_STUSB160X

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
scripts/config -d TYPEC_MUX_WCD939X_USBSS

scripts/config -d MMC_TEST

#
# MMC/SD/SDIO Host Controller Drivers
#
scripts/config -d MMC_ALCOR
scripts/config -d MMC_SPI
scripts/config -d MMC_USDHI6ROL0
scripts/config -d MMC_MTK
scripts/config -d SCSI_UFS_HWMON
scripts/config -d SCSI_UFSHCD_PLATFORM

#
# MemoryStick drivers
#
scripts/config -d MS_BLOCK

#
# MemoryStick Host Controller Drivers
#
scripts/config -d LEDS_BRIGHTNESS_HW_CHANGED

#
# LED drivers
#
scripts/config -d LEDS_CHT_WCOVE
scripts/config -d LEDS_LM3642
scripts/config -d LEDS_PCA9532_GPIO
scripts/config -d LEDS_PCA955X
scripts/config -d LEDS_PCA963X
scripts/config -d LEDS_PCA995X
scripts/config -d LEDS_DAC124S085
scripts/config -d LEDS_PWM
scripts/config -d LEDS_REGULATOR
scripts/config -d LEDS_BD2802
scripts/config -d LEDS_LT3593
scripts/config -d LEDS_TCA6507
scripts/config -d LEDS_TLC591XX
scripts/config -d LEDS_LM355x

#
# Flash and Torch LED drivers
#
scripts/config -d LEDS_LM3601X

#
# LED Triggers
#
scripts/config -d LEDS_TRIGGER_DISK
scripts/config -d LEDS_TRIGGER_MTD
scripts/config -d LEDS_TRIGGER_CPU

#
# iptables trigger is under Netfilter config (LED target)
#
scripts/config -d LEDS_TRIGGER_PANIC
scripts/config -d LEDS_TRIGGER_INPUT_EVENTS

#
# Simple LED drivers
#
scripts/config -d LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
scripts/config -d ACCESSIBILITY
scripts/config -d INFINIBAND_IRDMA
scripts/config -d INFINIBAND_MTHCA_DEBUG
scripts/config -d INFINIBAND_RTRS_SERVER
scripts/config -d EDAC_AMD64
scripts/config -d EDAC_IGEN6
scripts/config -d RTC_HCTOSYS
scripts/config -d RTC_SYSTOHC
scripts/config -d RTC_NVMEM

#
# RTC interfaces
#
scripts/config -d RTC_INTF_DEV_UIE_EMUL

#
# I2C RTC drivers
#
scripts/config -d RTC_DRV_ABB5ZES3
scripts/config -d RTC_DRV_ABEOZ9
scripts/config -d RTC_DRV_DS1307_CENTURY
scripts/config -d RTC_DRV_MAX31335
scripts/config -d RTC_DRV_PCF85363
scripts/config -d RTC_DRV_M41T80_WDT
scripts/config -d RTC_DRV_S35390A
scripts/config -d RTC_DRV_RV3028
scripts/config -d RTC_DRV_RV3032
scripts/config -d RTC_DRV_RV8803
scripts/config -d RTC_DRV_SD3078

#
# SPI RTC drivers
#
scripts/config -d RTC_DRV_DS1302

#
# SPI and I2C RTC drivers
#
scripts/config -d RTC_DRV_RX6110

#
# Platform RTC drivers
#
scripts/config -d RTC_DRV_M48T86

#
# on-CPU RTC drivers
#
scripts/config -d RTC_DRV_FTRTC010

#
# DMA Devices
#
scripts/config -d XILINX_DMA
scripts/config -d QCOM_HIDMA_MGMT
scripts/config -d QCOM_HIDMA

#
# DMA Clients
#
scripts/config -d ASYNC_TX_DMA

#
# DMABUF options
#
scripts/config -d DMABUF_HEAPS
scripts/config -d DMABUF_SYSFS_STATS

scripts/config -d UIO_PDRV_GENIRQ
scripts/config -d UIO_DMEM_GENIRQ
scripts/config -d UIO_NETX
scripts/config -d UIO_MF624
scripts/config -d VFIO_DEBUGFS

scripts/config -d NITRO_ENCLAVES
scripts/config -d VIRTIO_MMIO_CMDLINE_DEVICES
scripts/config -d VIRTIO_DEBUG
scripts/config -d SNET_VDPA
scripts/config -d OCTEONEP_VDPA

#
# Accelerometers
#
scripts/config -d ADIS16203
scripts/config -d ADIS16240

#
# Analog to digital converters
#
scripts/config -d AD7816

#
# Analog digital bi-direction converters
#
scripts/config -d ADT7316

#
# Direct Digital Synthesis
#
scripts/config -d AD9832
scripts/config -d AD9834

#
# Network Analyzer, Impedance Converters
#
scripts/config -d AD5933

scripts/config -d STAGING_MEDIA
scripts/config -d LTE_GDM724X
scripts/config -d CROS_EC_DEBUGFS
scripts/config -d CHROMEOS_PRIVACY_SCREEN
scripts/config -d CZNIC_PLATFORMS
scripts/config -d SURFACE_AGGREGATOR_REGISTRY
scripts/config -d SURFACE_DTX
scripts/config -d NVIDIA_WMI_EC_BACKLIGHT
scripts/config -d GIGABYTE_WMI
scripts/config -d ADV_SWBUTTON
scripts/config -d DELL_WMI_PRIVACY
scripts/config -d IBM_RTL
scripts/config -d INTEL_ATOMISP2_LED

scripts/config -d INTEL_BYTCRC_PWRSRC
scripts/config -d INTEL_CHTWC_INT33FE
scripts/config -d PCENGINES_APU2
scripts/config -d BARCO_P50_GPIO
scripts/config -d SONYPI_COMPAT
scripts/config -d TOUCHSCREEN_DMI
scripts/config -d SEL3350_PLATFORM
scripts/config -d LMK04832
scripts/config -d COMMON_CLK_MAX9485
scripts/config -d COMMON_CLK_SI5351
scripts/config -d COMMON_CLK_CDCE706
scripts/config -d COMMON_CLK_CS2000_CP
scripts/config -d COMMON_CLK_PWM
scripts/config -d HWSPINLOCK

scripts/config -d ALTERA_MBOX

#
# Remoteproc drivers
#
scripts/config -d REMOTEPROC_CDEV

#
# Rpmsg drivers
#
scripts/config -d RPMSG_CHAR
scripts/config -d RPMSG_QCOM_GLINK_RPM

#
# Qualcomm SoC drivers
#
scripts/config -d QCOM_PMIC_PDCHARGER_ULOG

scripts/config -d SOC_TI

#
# Extcon Device Drivers
#
scripts/config -d EXTCON_ADC_JACK
scripts/config -d EXTCON_GPIO
scripts/config -d EXTCON_MAX3355
scripts/config -d EXTCON_PTN5150
scripts/config -d EXTCON_RT8973A
scripts/config -d EXTCON_SM5502
scripts/config -d EXTCON_USB_GPIO
scripts/config -d MEMORY
scripts/config -d IIO_TRIGGERED_EVENT

#
# Accelerometers
#
scripts/config -d ADIS16201
scripts/config -d ADIS16209
scripts/config -d ADXL345_I2C
scripts/config -d ADXL345_SPI
scripts/config -d BMA180
scripts/config -d BMA220
scripts/config -d BMA400
scripts/config -d BMI088_ACCEL
scripts/config -d DMARD09
scripts/config -d FXLS8962AF_I2C
scripts/config -d FXLS8962AF_SPI
scripts/config -d KXSD9
scripts/config -d MC3230
scripts/config -d MMA7455_I2C
scripts/config -d MMA7455_SPI
scripts/config -d MMA8452
scripts/config -d MMA9551
scripts/config -d MMA9553
scripts/config -d MXC4005
scripts/config -d MXC6255
scripts/config -d SCA3000
scripts/config -d SCA3300
scripts/config -d STK8312
scripts/config -d STK8BA50

#
# Analog to digital converters
#
scripts/config -d AD7091R5
scripts/config -d AD7091R8
scripts/config -d AD7124
scripts/config -d AD7192
scripts/config -d AD7266
scripts/config -d AD7280
scripts/config -d AD7291
scripts/config -d AD7292
scripts/config -d AD7298
scripts/config -d AD7380
scripts/config -d AD7476
scripts/config -d AD7606_IFACE_PARALLEL
scripts/config -d AD7606_IFACE_SPI
scripts/config -d AD7768_1
scripts/config -d AD7780
scripts/config -d AD7791
scripts/config -d AD7793
scripts/config -d AD7887
scripts/config -d AD7923
scripts/config -d AD7949
scripts/config -d AD799X
scripts/config -d AD9467
scripts/config -d CC10001_ADC
scripts/config -d HI8435
scripts/config -d HX711
scripts/config -d INA2XX_ADC
scripts/config -d LTC2309
scripts/config -d LTC2471
scripts/config -d LTC2485
scripts/config -d LTC2496
scripts/config -d LTC2497
scripts/config -d MAX1027
scripts/config -d MAX11100
scripts/config -d MAX1118
scripts/config -d MAX1241
scripts/config -d MAX34408
scripts/config -d MAX9611
scripts/config -d MCP320X
scripts/config -d MCP3422
scripts/config -d NAU7802
scripts/config -d TI_ADC081C
scripts/config -d TI_ADC0832
scripts/config -d TI_ADC084S021
scripts/config -d TI_ADC12138
scripts/config -d TI_ADC108S102
scripts/config -d TI_ADC128S052
scripts/config -d TI_ADC161S626
scripts/config -d TI_ADS1119
scripts/config -d TI_ADS7950
scripts/config -d TI_ADS131E08
scripts/config -d TI_TLC4541
scripts/config -d TI_TSC2046
scripts/config -d VIPERBOARD_ADC
scripts/config -d XILINX_XADC

#
# Amplifiers
#
scripts/config -d AD8366
scripts/config -d HMC425

#
# Capacitance to digital converters
#
scripts/config -d AD7150
scripts/config -d AD7746

#
# Chemical Sensors
#
scripts/config -d AOSONG_AGS02MA
scripts/config -d ATLAS_PH_SENSOR
scripts/config -d ATLAS_EZO_SENSOR
scripts/config -d BME680
scripts/config -d CCS811
scripts/config -d IAQCORE
scripts/config -d PMS7003
scripts/config -d SCD30_CORE
scripts/config -d SENSIRION_SGP30
scripts/config -d SPS30_I2C
scripts/config -d SPS30_SERIAL
scripts/config -d VZ89X

#
# Digital to analog converters
#
scripts/config -d AD5064
scripts/config -d AD5360
scripts/config -d AD5380
scripts/config -d AD5421
scripts/config -d AD5446
scripts/config -d AD5449
scripts/config -d AD5592R
scripts/config -d AD5593R
scripts/config -d AD5504
scripts/config -d AD5624R_SPI
scripts/config -d AD5686_SPI
scripts/config -d AD5696_I2C
scripts/config -d AD5755
scripts/config -d AD5758
scripts/config -d AD5761
scripts/config -d AD5764
scripts/config -d AD5770R
scripts/config -d AD5791
scripts/config -d AD7303
scripts/config -d AD8801
scripts/config -d DS4424
scripts/config -d LTC2632
scripts/config -d M62332
scripts/config -d MAX517
scripts/config -d MCP4725
scripts/config -d MCP4821
scripts/config -d MCP4922
scripts/config -d TI_DAC082S085
scripts/config -d TI_DAC5571
scripts/config -d TI_DAC7311
scripts/config -d TI_DAC7612

#
# Clock Generator/Distribution
#
scripts/config -d AD9523

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
scripts/config -d ADF4350
scripts/config -d ADF4371

#
# Digital gyroscope sensors
#
scripts/config -d ADIS16080
scripts/config -d ADIS16130
scripts/config -d ADIS16136
scripts/config -d ADIS16260
scripts/config -d ADXRS290
scripts/config -d ADXRS450
scripts/config -d BMG160
scripts/config -d FXAS21002C
scripts/config -d ITG3200

#
# Heart Rate Monitors
#
scripts/config -d AFE4403
scripts/config -d AFE4404
scripts/config -d MAX30102

#
# Humidity sensors
#
scripts/config -d AM2315
scripts/config -d HDC100X
scripts/config -d HDC2010
scripts/config -d HDC3020
scripts/config -d HTU21
scripts/config -d SI7005
scripts/config -d SI7020

#
# Inertial measurement units
#
scripts/config -d ADIS16400
scripts/config -d ADIS16460
scripts/config -d ADIS16475
scripts/config -d ADIS16480
scripts/config -d BMI160_I2C
scripts/config -d BMI160_SPI
scripts/config -d BMI323_I2C
scripts/config -d BMI323_SPI
scripts/config -d FXOS8700_I2C
scripts/config -d FXOS8700_SPI
scripts/config -d KMX61
scripts/config -d INV_ICM42600_I2C
scripts/config -d INV_ICM42600_SPI
scripts/config -d INV_MPU6050_SPI
scripts/config -d IIO_ST_LSM6DSX
scripts/config -d IIO_ST_LSM9DS0

#
# Light sensors
#
scripts/config -d ADJD_S311
scripts/config -d ADUX1020
scripts/config -d AL3010
scripts/config -d AL3320A
scripts/config -d APDS9300
scripts/config -d APDS9960
scripts/config -d AS73211
scripts/config -d BH1780
scripts/config -d CM3232
scripts/config -d CM3323
scripts/config -d CM36651
scripts/config -d GP2AP020A00F
scripts/config -d SENSORS_ISL29018
scripts/config -d ISL29125
scripts/config -d JSA1212
scripts/config -d ROHM_BU27008
scripts/config -d LTR501
scripts/config -d MAX44000
scripts/config -d MAX44009
scripts/config -d NOA1305
scripts/config -d SI1133
scripts/config -d SI1145
scripts/config -d TCS3414
scripts/config -d TCS3472
scripts/config -d SENSORS_TSL2563
scripts/config -d TSL2583
scripts/config -d TSL2591
scripts/config -d TSL4531
scripts/config -d US5182D
scripts/config -d VCNL4000
scripts/config -d VCNL4035
scripts/config -d VEML6030
scripts/config -d VEML6070

#
# Magnetometer sensors
#
scripts/config -d BMC150_MAGN_I2C
scripts/config -d BMC150_MAGN_SPI
scripts/config -d MAG3110
scripts/config -d MMC35240
scripts/config -d SENSORS_HMC5843_I2C
scripts/config -d SENSORS_HMC5843_SPI
scripts/config -d SENSORS_RM3100_I2C
scripts/config -d SENSORS_RM3100_SPI
scripts/config -d YAMAHA_YAS530

#
# Triggers - standalone
#
scripts/config -d IIO_HRTIMER_TRIGGER

#
# Digital potentiometers
#
scripts/config -d DS1803
scripts/config -d MAX5432
scripts/config -d MAX5481
scripts/config -d MAX5487
scripts/config -d MCP4131
scripts/config -d MCP4531
scripts/config -d MCP41010
scripts/config -d TPL0102
scripts/config -d X9250

#
# Pressure sensors
#
scripts/config -d DLHL60D
scripts/config -d DPS310
scripts/config -d HP03
scripts/config -d HSC030PA
scripts/config -d ICP10100
scripts/config -d MPL115_I2C
scripts/config -d MPL115_SPI
scripts/config -d MPL3115
scripts/config -d MPRLS0025PA
scripts/config -d MS5611
scripts/config -d MS5637
scripts/config -d IIO_ST_PRESS
scripts/config -d T5403
scripts/config -d HP206C
scripts/config -d ZPA2326

#
# Lightning sensors
#
scripts/config -d AS3935

#
# Proximity and distance sensors
#
scripts/config -d IRSD200
scripts/config -d ISL29501
scripts/config -d LIDAR_LITE_V2
scripts/config -d MB1232
scripts/config -d PING
scripts/config -d RFD77402
scripts/config -d SX9310
scripts/config -d SX9500
scripts/config -d SRF08
scripts/config -d VCNL3020

#
# Resolver to digital converters
#
scripts/config -d AD2S90
scripts/config -d AD2S1200
scripts/config -d AD2S1210

#
# Temperature sensors
#
scripts/config -d LTC2983
scripts/config -d MLX90635
scripts/config -d TMP006
scripts/config -d TMP007
scripts/config -d TMP117
scripts/config -d TSYS01
scripts/config -d TSYS02D
scripts/config -d MAX31856
scripts/config -d MCP9600

scripts/config -d PWM_PCA9685

#
# IRQ chip support
#
scripts/config -d LAN966X_OIC

scripts/config -d IPACK_BUS
scripts/config -d RESET_GPIO
scripts/config -d RESET_SIMPLE
scripts/config -d RESET_TI_SYSCON

#
# PHY Subsystem
#
scripts/config -d USB_LGM_PHY
scripts/config -d PHY_CAN_TRANSCEIVER

#
# PHY drivers for Broadcom platforms
#
scripts/config -d BCM_KONA_USB2_PHY

scripts/config -d PHY_PXA_28NM_HSIC
scripts/config -d PHY_PXA_28NM_USB2
scripts/config -d PHY_QCOM_USB_HS
scripts/config -d PHY_QCOM_USB_HSIC
scripts/config -d PHY_TUSB1210

scripts/config -d MCB

#
# HW tracing support
#
scripts/config -d STM

scripts/config -d FPGA_MGR_XILINX_SELECTMAP

scripts/config -d SIOX
scripts/config -d SLIMBUS
scripts/config -d INTERCONNECT
scripts/config -d INTEL_QEP
scripts/config -d INTERRUPT_CNT
scripts/config -d MOST

#
# File systems
#
scripts/config -d REISERFS_FS
scripts/config -d JFS_FS
scripts/config -d XFS_SUPPORT_ASCII_CI
scripts/config -d XFS_ONLINE_SCRUB
scripts/config -d GFS2_FS
scripts/config -d OCFS2_FS
scripts/config -d NILFS2_FS
scripts/config -d F2FS_FS_SECURITY
scripts/config -d F2FS_CHECK_FS
scripts/config -d F2FS_FS_COMPRESSION
scripts/config -d F2FS_IOSTAT
scripts/config -d F2FS_UNFAIR_RWSEM
scripts/config -d BCACHEFS_QUOTA
scripts/config -d BCACHEFS_POSIX_ACL
scripts/config -d BCACHEFS_LOCK_TIME_STATS
scripts/config -d ZONEFS_FS
scripts/config -d FS_VERITY
scripts/config -d QUOTA
scripts/config -d OVERLAY_FS_REDIRECT_DIR
scripts/config -d OVERLAY_FS_INDEX
scripts/config -d OVERLAY_FS_XINO_AUTO
scripts/config -d OVERLAY_FS_METACOPY

#
# Caches
#
scripts/config -d NETFS_STATS
scripts/config -d NETFS_DEBUG
scripts/config -d FSCACHE_STATS
scripts/config -d CACHEFILES_ONDEMAND

#
# DOS/FAT/EXFAT/NT Filesystems
#
scripts/config -d MSDOS_FS

#
# Pseudo filesystems
#
scripts/config -d PROC_KCORE
scripts/config -d TMPFS_QUOTA

scripts/config -d ORANGEFS_FS
scripts/config -d AFFS_FS
scripts/config -d HFS_FS
scripts/config -d BEFS_FS
scripts/config -d JFFS2_FS
scripts/config -d UBIFS_FS
scripts/config -d CRAMFS_MTD
scripts/config -d MINIX_FS
scripts/config -d OMFS_FS
scripts/config -d ROMFS_FS
scripts/config -d PSTORE_RAM
scripts/config -d PSTORE_BLK
scripts/config -d UFS_FS
scripts/config -d EROFS_FS_ZIP_LZMA
scripts/config -d EROFS_FS_ZIP_DEFLATE
scripts/config -d EROFS_FS_ZIP_ZSTD
scripts/config -d EROFS_FS_ONDEMAND
scripts/config -d EROFS_FS_PCPU_KTHREAD_HIPRI
scripts/config -d NFS_V3_ACL
scripts/config -d NFS_SWAP
scripts/config -d NFS_FSCACHE
scripts/config -d NFSD_V3_ACL
scripts/config -d NFSD_V4_SECURITY_LABEL
scripts/config -d RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA
scripts/config -d SUNRPC_DEBUG
scripts/config -d CIFS_UPCALL
scripts/config -d CIFS_XATTR
scripts/config -d CIFS_DEBUG
scripts/config -d CIFS_SMB_DIRECT
scripts/config -d CIFS_FSCACHE
scripts/config -d CODA_FS
scripts/config -d AFS_FS
scripts/config -d 9P_FSCACHE
scripts/config -d 9P_FS_SECURITY
scripts/config -d DLM_DEBUG

#
# Crypto core or helper
#
scripts/config -d CRYPTO_FIPS
scripts/config -d CRYPTO_MANAGER_DISABLE_TESTS
scripts/config -d CRYPTO_MANAGER_EXTRA_TESTS

#
# Length-preserving ciphers and modes
#
scripts/config -d CRYPTO_ADIANTUM
scripts/config -d CRYPTO_HCTR2

#
# AEAD (authenticated encryption with associated data) ciphers
#
scripts/config -d CRYPTO_AEGIS128

#
# Hashes, digests, and MACs
#
scripts/config -d CRYPTO_RMD160

