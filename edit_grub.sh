#!/bin/bash

sed -i '/#GRUB_CMDLINE_LINUX_DEFAULT/d' /etc/default/grub

if ! `grep -q GRUB_CMDLINE_LINUX_DEFAULT /etc/default/grub`; then
    sed -i '11 i GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable acpi_cpufreq_coord_type_force=sw_all"' /etc/default/grub
fi

if ! `grep 'intel_pstate=disable' /etc/default/grub| grep -q GRUB_CMDLINE_LINUX_DEFAULT`; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable /g' /etc/default/grub
fi
if ! `grep 'acpi_cpufreq_coord_type_force=sw_all' /etc/default/grub| grep -q GRUB_CMDLINE_LINUX_DEFAULT`; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="acpi_cpufreq_coord_type_force=sw_all /g' /etc/default/grub
fi
update-grub
