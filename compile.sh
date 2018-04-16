#!/bin/sh -x
cd $HOME
sudo su -c "grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list"
sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://linux.yz.yamagata-u.ac.jp/pub/linux/ubuntu-archive/@g" /etc/apt/sources.list

sudo apt update -qq
sudo apt install -y git
sudo apt-get build-dep -qq linux
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.34.tar.xz
tar xf linux-4.14.34.tar.xz
cd linux-4.14.34
patch -p1 < /vagrant/hakase.patch
yes "" | make oldconfig
make
sudo make modules_install
sudo make headers_install
sudo make install
cd ..
sudo rm -rf linux-4.14.34 linux-4.14.34.tar.gz
sudo sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet memmap=0x80000000\$0x80000000\"/g" /etc/default/grub
sudo update-grub2
