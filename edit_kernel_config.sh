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

CONF_FILE=$KERNEL_PATH/.config

if `grep -q 'CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y' $CONF_FILE`; then
    sed -i 's/CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y/# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set/g' $CONF_FILE
    sed -i 's/# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set/CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y/g' $CONF_FILE
fi
sed -i 's/.*CONFIG_CPU_FREQ_GOV_ONDEMAND.*/CONFIG_CPU_FREQ_GOV_ONDEMAND=m/' $CONF_FILE

sed -i 's/.*CONFIG_X86_MSR.*/CONFIG_X86_MSR=m/' $CONF_FILE

echo "Successfully updated .conf"
