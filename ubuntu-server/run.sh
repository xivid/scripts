#!/bin/bash

exec qemu-system-x86_64 -drive file=ubuntu.qcow2,format=qcow2 -enable-kvm -m 16G -smp 4 -cpu host -device e1000,netdev=net -netdev user,id=net,hostfwd=tcp::2222-:22 \
       -kernel ~/repo/linux-kernel/linux-5.16.2/arch/x86/boot/bzImage -append "root=/dev/sda1 console=ttyS0" -nographic	
