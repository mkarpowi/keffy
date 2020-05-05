#!/bin/bash

export LINUX_VERSION=5.6.4
#export LINUX_VERSION=4.11-rc2
export TOP_DIR=~/work


export CPUFREQ_REPO=git@git2.zisi.nask.pl:cpu_control/cpufreq.git
export TELEMETRY_REPO=git@git2.zisi.nask.pl:cpu_control/telemetry.git
export CONTROLLER_REPO=git@git2.zisi.nask.pl:cpu_control/controller.git
export LOAD_STRESS_REPO=git@git2.zisi.nask.pl:cpu_control/load_stress.git


export KERNEL_PATH=$TOP_DIR/linux-$LINUX_VERSION
export CPUFREQ_PATH=$KERNEL_PATH/drivers/cpufreq/
export TELEMETRY_PATH=$TOP_DIR/telemetry
export LOAD_STRESS_PATH=$TOP_DIR/load_stress
export CONTROLLER_PATH=$TOP_DIR/controller
export CONTROLLER_CONF_PATH=$PWD
