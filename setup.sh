#!/bin/sh -x
vagrant up
vagrant ssh -c "sudo bash -x /vagrant/compile.sh"
vagrant reload
vbox_version=`virtualbox --help | sed -n 1P | cut -d' ' -f5`
vagrant ssh -c "wget https://raw.githubusercontent.com/liva/hakase_vboxenv/master/install_vboxguestadditions.sh;
                bash -x ./install_vboxguestadditions.sh ${vbox_version};
                rm ./install_vboxguestadditions.sh"
vagrant reload
vagrant ssh -c "sh -x /vagrant/cleanup.sh"
vagrant package
