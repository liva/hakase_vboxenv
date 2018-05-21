#!/bin/bash -x
LINUXDIR="/proc"
if [ -d ${LINUXDIR} ]; then
  memall=`set -- $(free -tg | sed -n 2P); echo $2`
else
  memall=`set -- $(system_profiler SPHardwareDataType | grep Memory); echo $2`
fi
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/4096/2048/g' Vagrantfile
fi
vagrant up
vagrant ssh -c "sudo bash -x /vagrant/compile.sh"
if [ ${memall} -lt 7 ]; then
  sed -i -e 's/2048/4096/g' Vagrantfile
fi
vagrant reload
