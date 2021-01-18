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
PERFLIB_FILE=$KERNEL_PATH/drivers/acpi/processor_perflib.c

if `grep -q 'coord_type_force' $PERFLIB_FILE`; then
    echo "Perflib patch has already been applied."
    exit 0
fi

sed -i '/static DEFINE_MUTEX(performance_mutex);/a \
\
/*\
 * This variable contains early init parameter acpi_cpufreq_coord_type_force\
 * value.\
 */\
\
static unsigned int coord_type_force = CPUFREQ_SHARED_TYPE_NONE;' $PERFLIB_FILE


sed -i '/Validate the Domain info/{n;N;N;N;N;N;N;N;d}' $PERFLIB_FILE
sed -i '/Validate the Domain info/a \
		count_target = pdomain->num_processors;\
\
		\/\/ Check if coordination type forcing is requested\
		if (coord_type_force == CPUFREQ_SHARED_TYPE_NONE) {\
\
			if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)\
				pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;\
			else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)\
				pr->performance->shared_type = CPUFREQ_SHARED_TYPE_HW;\
			else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)\
				pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;\
\
		} else {\
\
			\/\/ Force requested coordination type\
			pr->performance->shared_type = coord_type_force;\
\
			switch (coord_type_force) {\
				case CPUFREQ_SHARED_TYPE_ALL:\
					pr_info(PREFIX "CPU performance level coordination type forced to sw_all\\n");\
					break;\
				case CPUFREQ_SHARED_TYPE_ANY:\
					pr_info(PREFIX "CPU performance level coordination type forced to sw_any\\n");\
					break;\
				case CPUFREQ_SHARED_TYPE_HW:\
					pr_info(PREFIX "CPU performance level coordination type forced to hw_all\\n");\
					break;\
				default:\
					pr_err(PREFIX "CPU performance level coordination type forced to unknown (%x)\\n", coord_type_force);\
			}\
\
		}' $PERFLIB_FILE

sed -i '/EXPORT_SYMBOL(acpi_processor_unregister_performance);/a \
\
\/*\
 * Early init parameter acpi_cpufreq_coord_type_force declaration and parsing.\
 * This parameter allows to force any of possible ACPI CPU performance\
 * level coordination variant.\
 *\
 * Possible values for early init acpi_cpufreq_coord_type_force parameter:\
 *	- sw_all\
 *	- sw_any\
 *	- hw_all\
 *\/\
\
static int __init coord_type_force_setup(char *str)\
{\
\
	if (!str)\
		return -EINVAL;\
\
	pr_debug(PREFIX "Param value provided: %s", str);\
\
	if (strcmp(str, "sw_all") == 0)\
		coord_type_force = CPUFREQ_SHARED_TYPE_ALL;\
	else if (strcmp(str, "sw_any") == 0)\
		coord_type_force = CPUFREQ_SHARED_TYPE_ANY;\
	else if (strcmp(str, "hw_all") == 0)\
		coord_type_force = CPUFREQ_SHARED_TYPE_HW;\
\
	return 0;\
\
}\
\
early_param("acpi_cpufreq_coord_type_force", coord_type_force_setup);' $PERFLIB_FILE
