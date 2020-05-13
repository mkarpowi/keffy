#!/bin/bash

source config.sh

cp $CPUFREQ_ADAPTIVE_PATH/cpufreq_adaptive.c $CPUFREQ_PATH
cp $CPUFREQ_ADAPTIVE_PATH/cpufreq_adaptive.h $CPUFREQ_PATH
cp $CPUFREQ_ADAPTIVE_PATH/tlmt.h $CPUFREQ_PATH
