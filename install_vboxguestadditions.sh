#!/bin/sh -x
wget http://download.virtualbox.org/virtualbox/${vbox_version}/VBoxGuestAdditions_${vbox_version}.iso
sudo mkdir -p /mnt/iso
sudo mount VBoxGuestAdditions_${vbox_version}.iso /mnt/iso
pushd /mnt/iso
sudo ./VBoxLinuxAdditions.run
popd
rm VBoxGuestAdditions_${vbox_version}.iso
sudo rm -r /mnt/iso
