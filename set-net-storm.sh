#!/usr/bin/env bash

# Simple script to set basic parameters of the Net.Storm network emulator

if [[ $# -ne 3 ]]
then
    >&2 echo "Usage: ${0} [delay] [loss] [bandwidth]"
    >&2 echo "    [delay]     is given in microseconds, i.e., 1000 ~ 1 ms"
    >&2 echo "    [loss]      is given in 1/10,000th of a percent, i.e., 10000 ~ 1%"
    >&2 echo "    [bandwidth] is given in bps, i.e., 1000000 ~ 1 Mbps"
    >&2 echo "All values are set in BOTH directions, e.g., setting delay to 1 ms will result in 2 ms RTT!"
    exit 1
fi

DELAY=${1}
LOSS=${2}
BANDWIDTH=${3}

DELAY_MODE_DETERMINISTIC="1"
LOSS_MODE_RANDOM="6"
BANDWIDTH_MODE_SHAPING_BIT="3"
BANDWIDTH_MODE_POLICING_BIT="4"

READ_COMM=rbnetr
WRITE_COMM=rbnetw
TARGET=nem.cs.unh.edu
MIB=ATSL-PSN-IMPAIRMENT-MIB

# disable emulation
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpEnable i false

# set delay
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelayMode.16 i ${DELAY_MODE_DETERMINISTIC}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelay.16 i ${DELAY}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelayMode.32 i ${DELAY_MODE_DETERMINISTIC}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelay.32 i ${DELAY}

# sanity check delay
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelayMode.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelay.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelayMode.32
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpDelay.32

# set loss
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossMode.16 i ${LOSS_MODE_RANDOM}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossProbability.16 u ${LOSS}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossMode.32 i ${LOSS_MODE_RANDOM}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossProbability.32 u ${LOSS}

# sanity check loss
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossMode.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossProbability.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossMode.32
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpLossProbability.32

# set bandwidth
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthMode.16 i ${BANDWIDTH_MODE_SHAPING_BIT}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthBitRate.16 i ${BANDWIDTH}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthMode.32 i ${BANDWIDTH_MODE_SHAPING_BIT}
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthBitRate.32 i ${BANDWIDTH}

# sanity check bandwidth
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthMode.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthBitRate.16
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthMode.32
snmpget -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpBandwidthBitRate.32

# enable emulation
snmpset -v 2c -c ${WRITE_COMM} ${TARGET} ${MIB}::psnImpEnable i true
  