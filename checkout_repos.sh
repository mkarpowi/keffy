#!/bin/bash

source config.sh
cd $CONTROLLER_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $CONTROLLER_REPO
fi
git fetch;
git checkout master;
git merge origin/master;

cd $TELEMETRY_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $TELEMETRY_REPO
fi
git fetch;
git checkout master-$LINUX_VERSION;
git merge origin/master-$LINUX_VERSION;

cd $CPUFREQ_PATH
if ! git remote | grep origin > /dev/null; then
    git remote add origin $CPUFREQ_REPO
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
