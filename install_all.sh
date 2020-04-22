#!/bin/bash

source config.sh

f () {
    echo $ER
    if [ "$ER" != "0" ]; then
        errorCode=$? # save the exit code as the first thing done in the trap function
        echo "error $errorCode"
        echo "the command executing at the time of the error was"
        echo "$BASH_COMMAND"
        echo "on line ${BASH_LINENO[0]}"
        exit $errorCode
    fi
}

trap f ERR

sudo /bin/bash edit_grub.sh
echo "Successfully modified grub file"
/bin/bash get_kernel.sh
echo "Successfully downloaded kernel"
/bin/bash clone_repos.sh
echo "Successfully cloned repos"
/bin/bash checkout_repos.sh
echo "Successfully checked-out repos"
/bin/bash compile_repos.sh
echo "Successfully compiled repos"
/bin/bash apply_perflib_patch.sh
echo "Successfully applied perflib_patches"
/bin/bash copy_to_kernel.sh
echo "Successfully copied sources to kernel"
/bin/bash compile_kernel.sh
echo "Successfully compiled kernel"
