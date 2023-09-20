#!/bin/sh

#Retrieve latest Linux Kernel and unpack
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.tar.xz
tar xvf linux-6.5.tar.xz
cd linux-6.5

#Build Kernel
make defconfig
make kvm_guest.config
make -j 4

#Assume qemu is installed
qemu-img create -f qcow2 test.img 100M

#Launch qemu, assuming the location is x86 here
qemu-system-x86_64 -kernel arch/x86/boot/bzImage
                     -append "root=/dev/sda console=ttyS0"
                     -hda test.img
                     --enable-kvm
                     --nographic
					 
