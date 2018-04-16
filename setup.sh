#!/bin/sh -x
vagrant up
vagrant ssh -c "bash /vagrant/compile.sh"
vagrant reload
vbox_version=`virtualbox --help | sed -n 1P | cut -d' ' -f5`
vagrant ssh -c "wget http://download.virtualbox.org/virtualbox/${vbox_version}/VBoxGuestAdditions_${vbox_version}.iso;
                sudo mkdir -p /mnt/iso;
                sudo mount VBoxGuestAdditions_${vbox_version}.iso /mnt/iso;
                pushd /mnt/iso;
                sudo ./VBoxLinuxAdditions.run;
                popd;
                rm VBoxGuestAdditions_${vbox_version}.iso;"
vagrant reload
vagrant ssh -c "bash /vagrant/cleanup.sh"
vagrant package
