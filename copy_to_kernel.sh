#!/bin/bash
f () {
    errorCode=$? # save the exit code as the first thing done in the trap function
    echo "error $errorCode"
    echo "the command executing at the time of the error was"
    echo "$BASH_COMMAND"
    echo "on line ${BASH_LINENO[0]}"
    1>&2
    exit $errorCode
}

trap f ERR

source config.sh

cp $CONTROLLER_PATH/controller.c         $CPUFREQ_PATH/
cp $CONTROLLER_PATH/controller_params.c  $CPUFREQ_PATH/
cp $CONTROLLER_PATH/fixed_point_aryth.c  $CPUFREQ_PATH/
cp $CONTROLLER_PATH/linear_solver.c      $CPUFREQ_PATH/
cp $CONTROLLER_PATH/matrix_operations.c  $CPUFREQ_PATH/
sed '/#define __user_space__/d' $CONTROLLER_PATH/controller.h > $CONTROLLER_PATH/controller_kernel.h
mv $CONTROLLER_PATH/controller_kernel.h  $CPUFREQ_PATH/controller.h
cp $CONTROLLER_PATH/controller_params.h  $CPUFREQ_PATH/
cp $CONTROLLER_PATH/fixed_point_aryth.h  $CPUFREQ_PATH/
cp $CONTROLLER_PATH/linear_solver.h      $CPUFREQ_PATH/
cp $CONTROLLER_PATH/matrix_operations.h  $CPUFREQ_PATH/
