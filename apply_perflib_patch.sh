source config.sh
cp perflib_patches/processor_perflib-$LINUX_VERSION.c $KERNEL_PATH/drivers/acpi/processor_perflib.c
cp perflib_patches/Makefile-$LINUX_VERSION $KERNEL_PATH/drivers/acpi/Makefile
