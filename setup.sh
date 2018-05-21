#!/bin/sh -x
memall=`free -tg | sed -n 2P | cut -d' ' -f15`
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/4096/2048/g' Vagrantfile
fi
vagrant up
vagrant ssh -c "sudo bash -x /vagrant/compile.sh"
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/2048/4096/g' Vagrantfile
fi
vagrant reload
