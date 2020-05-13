#!/bin/bash

source config.sh
MAKEFILE=$CPUFREQ_PATH/Makefile

if `grep -q 'cpufreq_adaptive' $MAKEFILE`; then
    echo "cpufreq Makefile patch has already been applied."
    exit 0
fi

sed -i '/CPUfreq governors/a \
obj-m					+= cpufreq_adaptive.o' $MAKEFILE

