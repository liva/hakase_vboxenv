# hakase_vboxenv
hakase_vboxenv is a repository to build _hakase_ kernel debian package.

## Dependencies
- [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- vagrant-vbguest

## Setup
First, install vagrant-vbguest as follows:
```
$ vagrant plugin install vagrant-vbguest
```

To build _hakase_ kernel, simply run:
```
$ ./setup.sh
```
After building the kernel, you’ll see three debian packages in `/usr/src`.
```
linux-headers-4.14.34hakase_4.14.34hakase-1_amd64.deb
linux-image-4.14.34hakase_4.14.34hakase-1_amd64.deb
linux-libc-dev_4.14.34hakase-1_amd64.deb
```
