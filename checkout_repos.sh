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

cd $TELEMETRY_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $TELEMETRY_REPO
fi
git fetch;
git checkout master;
git merge origin/master;

cd $CPUFREQ_ADAPTIVE_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $CPUFREQ_ADAPTIVE_REPO
fi
git fetch;
git checkout master-$LINUX_VERSION;
git merge origin/master-$LINUX_VERSION;

cd $LOAD_STRESS_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $LOAD_STRESS_REPO
fi
git fetch;
git checkout master;
git merge origin/master;
