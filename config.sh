#!/bin/bash

export LINUX_VERSION=5.3.1
export TOP_DIR=~/work


export CPUFREQ_ADAPTIVE_REPO=git@git2.zisi.nask.pl:cpu_control/cpufreq_adaptive.git
export TELEMETRY_REPO=git@git2.zisi.nask.pl:cpu_control/telemetry.git
export LOAD_STRESS_REPO=git@git2.zisi.nask.pl:cpu_control/load_stress.git


export KERNEL_PATH=$TOP_DIR/linux-$LINUX_VERSION
export CPUFREQ_PATH=$KERNEL_PATH/drivers/cpufreq
export CPUFREQ_ADAPTIVE_PATH=$TOP_DIR/cpufreq_adaptive
export TELEMETRY_PATH=$TOP_DIR/telemetry
export LOAD_STRESS_PATH=$TOP_DIR/load_stress
export CONTROLLER_CONF_PATH=$PWD
