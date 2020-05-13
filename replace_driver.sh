#!/bin/bash

source config.sh

echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
rmmod cpufreq_adaptive
insmod $CPUFREQ_PATH/cpufreq_adaptive.ko
echo "adaptive" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
