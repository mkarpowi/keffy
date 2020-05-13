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

cd $TOP_DIR
if [ ! -d "$TOP_DIR/telemetry" ]; then
    git clone $TELEMETRY_REPO
fi

if [ ! -d "$TOP_DIR/load_stress" ]; then
    git clone $LOAD_STRESS_REPO
fi

if [ ! -d "$TOP_DIR/cpufreq_adaptive" ]; then
    git clone $CPUFREQ_ADAPTIVE_REPO
fi

