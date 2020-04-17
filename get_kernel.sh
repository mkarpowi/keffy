source config.sh

cd $TOP_DIR
wget https://cdn.kernel.org/pub/linux/kernel/v${LINUX_VERSION:0:1}.x/linux-$LINUX_VERSION.tar.xz
tar -xvf linux-$LINUX_VERSION.tar.xz
rm linux-$LINUX_VERSION.tar.xz
