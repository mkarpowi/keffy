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
git clone $TELEMETRY_REPO
git clone $LOAD_STRESS_REPO
git clone $CONTROLLER_REPO
cd $CPUFREQ_PATH
git init
git remote add origin $CPUFREQ_REPO
git fetch;
git clean -f;
git checkout master-$LINUX_VERSION;
git merge origin/master-$LINUX_VERSION;
