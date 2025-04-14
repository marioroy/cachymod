#!/bin/bash

# Check if GCC is installed
check_gcc() {
  if ! [ -x "$(command -v gcc)" ]; then
    # Display error message if GCC is not installed
    echo "Error: GCC is not installed. Please install GCC and try again." >&2
    exit 1
  fi
}

# Call the function before running the rest of the script
check_gcc

# Get the CPU type from GCC and convert to uppercase
MARCH=$(gcc -Q -march=native --help=target|grep -m1 march=|awk '{print toupper($2)}')

# Get the CPU family and model from lscpu
FAMILY=$(lscpu | awk '/^CPU family:/ { print $3; exit }')
MODEL=$(lscpu | awk '/^Model:/ { print $2; exit }')

# Check for specific CPU types and set MARCH variable accordingly
if [[ "$FAMILY" = "6" && "$MODEL" = "207" ]]; then
  MARCH="EMERALDRAPIDS"  # 06_CFH Intel Emerald Rapids Server microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" = "143" ]]; then
  MARCH="SAPPHIRERAPIDS" # 06_8FH Intel Sapphire Rapids Server microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" = "170" ]]; then
  MARCH="METEORLAKE"     # 06_AAH Intel Meteor Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" =~ (183|186|191) ]]; then
  MARCH="RAPTORLAKE"     # 06_B7H,BAH,BFH Intel Raptor Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" =~ (151|154) ]]; then
  MARCH="ALDERLAKE"      # 06_97H,9AH Intel Alder Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" =~ (140|141) ]]; then
  MARCH="TIGERLAKE"      # 06_8CH,8DH Intel Tiger Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" = "167" ]]; then
  MARCH="ROCKETLAKE"     # 06_A7H Intel Rocket Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" = "102" ]]; then
  MARCH="CANNONLAKE"     # 06_66H Intel Cannon Lake microarchitecture
elif [[ "$FAMILY" = "6" && "$MODEL" =~ (165|166) ]]; then
  MARCH="SKYLAKE"        # 06_A5H,A6H Intel Comet Lake microarchitecture
                         # Use SKYLAKE as --march=cometlake not supported
else
  case $MARCH in
    ZNVER1) MARCH="ZEN";;
    ZNVER2) MARCH="ZEN2";;
    ZNVER3) MARCH="ZEN3";;
    ZNVER4) MARCH="ZEN4";;
    ZNVER5) MARCH="ZEN5";;
    BDVER1) MARCH="BULLDOZER";;
    BDVER2) MARCH="PILEDRIVER";;
    BDVER3) MARCH="STEAMROLLER";;
    BDVER4) MARCH="EXCAVATOR";;
    BTVER1) MARCH="BOBCAT";;
    BTVER2) MARCH="JAGUAR";;
    AMDFAM10) MARCH="MK10";;
    K8-SSE3) MARCH="K8SSE3";;
    BONNELL) MARCH="ATOM";;
    GOLDMONT-PLUS) MARCH="GOLDMONTPLUS";;
    SKYLAKE-AVX512) MARCH="SKYLAKEX";;
    MIVYBRIDGE)
      scripts/config --disable CONFIG_AGP_AMD64 
      scripts/config --disable CONFIG_MICROCODE_AMD
      MARCH="MIVYBRIDGE";;
    ICELAKE) MARCH="ICELAKE_CLIENT";;
    ICELAKE-CLIENT) MARCH="ICELAKE_CLIENT";;
    ICELAKE-SERVER) MARCH="ICELAKE_SERVER";;
  esac
fi

# Add "M" prefix to MARCH variable
MARCH2=M${MARCH}

# Display detected CPU and apply optimization
echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : ${MARCH2}"
scripts/config -k --disable CONFIG_GENERIC_CPU
scripts/config -k --enable CONFIG_${MARCH2}
