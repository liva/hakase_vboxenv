#!/bin/sh -x
sudo apt remove -y linux-image-4.4.0-87-generic linux-image-extra-4.4.0-87-generic linux-libc-dev
sudo apt-get autoremove
sudo rm -r /var/lib/apt/lists/*
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

