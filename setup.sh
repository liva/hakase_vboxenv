#!/bin/sh -x
memall=`free -tg | sed -n 2P | cut -d' ' -f15`
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/4096/1024/g' Vagrantfile
fi
vagrant up
vagrant ssh -c "sudo bash -x /vagrant/compile.sh"
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/1024/4096/g' Vagrantfile
fi
vagrant reload
WINDIR="/mnt/c/Windows"
if [ -d ${WINDIR} ]; then
  vbox_version=`VBoxManage.exe --help | sed -n 1P | cut -d' ' -f9 | tr -d "\r"`
else
  vbox_version=`virtualbox --help | sed -n 1P | cut -d' ' -f5`
fi
vagrant ssh -c "wget https://raw.githubusercontent.com/liva/hakase_vboxenv/master/install_vboxguestadditions.sh;
                bash -x ./install_vboxguestadditions.sh ${vbox_version};
                rm ./install_vboxguestadditions.sh"
vagrant reload
vagrant ssh -c "sh -x /vagrant/cleanup.sh"
vagrant package
