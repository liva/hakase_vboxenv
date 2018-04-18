#!/bin/bash -x
wget http://download.virtualbox.org/virtualbox/$1/VBoxGuestAdditions_$1.iso
sudo mkdir -p /mnt/iso
sudo mount VBoxGuestAdditions_$1.iso /mnt/iso
pushd /mnt/iso
sudo ./VBoxLinuxAdditions.run
popd
sudo umount /mnt/iso
rm VBoxGuestAdditions_$1.iso
sudo rm -r /mnt/iso
