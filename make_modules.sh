#!/bin/bash

source config.sh

cd $KERNEL_PATH

make modules_prepare
make -j4 M=drivers/cpufreq
