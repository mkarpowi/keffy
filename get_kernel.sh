#!/bin/bash

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
