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
/bin/bash copy_driver_to_kernel.sh
cd $TELEMETRY_PATH
make clean; make KERNEL_PATH=$KERNEL_PATH
cd $CONTROLLER_CONF_PATH
/bin/bash make_modules.sh
sudo /bin/bash replace_driver.sh
cd $TELEMETRY_PATH
sleep 1
sudo ./tlm
cd $LOAD_STRESS_PATH
./lstress -c 4 -w 5.5 &
sleep 10
kill -9 $(pgrep lstress)
sleep 10
./lstress -c 1 -w 0.5 &
sleep 5
echo 90 | sudo tee -a /sys/devices/system/cpu/cpufreq/adaptive/uc
sleep 5
echo 60 | sudo tee -a /sys/devices/system/cpu/cpufreq/adaptive/uc
sleep 5
echo 90 | sudo tee -a /sys/devices/system/cpu/cpufreq/adaptive/uc
sleep 5
echo 60 | sudo tee -a /sys/devices/system/cpu/cpufreq/adaptive/uc
kill -9 $(pgrep lstress)
cd $TELEMETRY_PATH
sudo ./tlm -f csv > data.txt; python3 plot_kernel_data.py
