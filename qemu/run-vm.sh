#!/bin/bash

exec qemu-system-x86_64 --enable-kvm \
       	-cpu host -m 16G -smp 4 \
	-drive if=virtio,file=ubuntu.img,format=qcow2 \
	-drive if=virtio,file=user-data.img,format=raw \
       	-device e1000,netdev=net -netdev user,id=net,hostfwd=tcp::2222-:22 \
       	-nographic
