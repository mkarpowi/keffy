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
f () {
    errorCode=$? # save the exit code as the first thing done in the trap function
    echo "ERROR: In case of using very specific version of the kernel, provide your own sources"
    1>&2
    exit $errorCode
}
trap f ERR

cd $TOP_DIR
wget https://cdn.kernel.org/pub/linux/kernel/v${LINUX_VERSION:0:1}.x/linux-$LINUX_VERSION.tar.xz
tar -xvf linux-$LINUX_VERSION.tar.xz
rm linux-$LINUX_VERSION.tar.xz
