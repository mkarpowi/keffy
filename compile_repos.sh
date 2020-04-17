source config.sh

cd $TELEMETRY_PATH
make
cd $LOAD_STRESS_PATH
make
cd $CONTROLLER_PATH
make
