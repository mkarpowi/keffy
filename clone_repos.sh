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
