#!/bin/bash


f () {
    errorCode=$? # save the exit code as the first thing done in the trap function
    echo "error $errorCode"
    echo "the command executing at the time of the error was"
    echo "$BASH_COMMAND"
    echo "on line ${BASH_LINENO[0]}"
    exit $errorCode
}

trap f ERR

source config.sh
sudo /bin/bash edit_grub.sh
echo "Successfully modified grub file"
/bin/bash get_kernel.sh
echo "Successfully downloaded kernel"
git submodule init
git submodule update
echo "Successfully cloned repos"
/bin/bash apply_perflib_patch.sh
echo "Successfully applied perflib_patches"
/bin/bash copy_driver_to_kernel.sh
echo "Successfully copied sources to kernel"
/bin/bash patch_cpufreq_makefile.sh
echo "Successfully patched cpufreq makefile"
/bin/bash compile_repos.sh
echo "Successfully compiled repos"
/bin/bash compile_kernel.sh
echo "Successfully compiled kernel"
