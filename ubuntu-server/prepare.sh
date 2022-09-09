#!/bin/bash

iso_name=ubuntu.iso
disk_img=ubuntu.qcow2

if [ ! -f ${iso_name} ]; then
	curl https://mirror.init7.net/ubuntu-releases/20.04.5/ubuntu-20.04.5-live-server-amd64.iso -o ${iso_name}
fi

qemu-img create -f qcow2 ${disk_img} 100G

qemu-system-x86_64 \
        -cdrom ${iso_name} \
        -drive "file=${disk_img},format=qcow2" \
        -enable-kvm \
        -m 2G \
        -smp 2 \
        ;

