source config.sh

echo "Installing kernel build utilities"
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

echo "Configuring kernel options"
cd $KERNEL_PATH
yes "" | make localmodconfig
/bin/bash $CONTROLLER_CONF_PATH/edit_kernel_config.sh
yes "" | make oldconfig

echo "Compiling kernel"
make -j $(nproc)

echo "Installing kernel modules"
sudo make modules_install

echo "Installing kernel"
sudo make install
