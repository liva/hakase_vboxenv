#!/bin/bash -x

cd /usr/src
su -c "grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list"
sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://linux.yz.yamagata-u.ac.jp/pub/linux/ubuntu-archive/@g" /etc/apt/sources.list

dd if=/dev/zero of=/swap bs=1M count=4096
chmod 600 /swap
mkswap /swap
swapon /swap

apt update -qq
apt install -y git
apt-get build-dep -qq linux
cp /vagrant/hakase.patch .
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.34.tar.xz
tar xf linux-4.14.34.tar.xz
ln -s linux-4.14.34 linux
pushd linux
patch -p1 < ../hakase.patch
yes "" | make oldconfig
make
make modules_install
make headers_install
make install
popd
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet memmap=0x80000000\$0x80000000\"/g" /etc/default/grub
update-grub2
swapoff /swap
