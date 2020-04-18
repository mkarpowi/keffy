source config.sh

cd $KERNEL_PATH
cp /boot/config-$(uname -r) .config

echo "Installing kernel build utilities"
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

make menuconfig
make -j $(nproc)
make modules_install

echo "Install kernel"
sudo make install
