#!/bin/bash

sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils cloud-image-utils virt-manager

if [ ! -f ubuntu.img ]; then
	echo "Download ubuntu cloud image..."
	echo "==============================="
	curl https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img -o ubuntu.img

	echo "Resize the image to a larger size..."
	echo "===================================="
	qemu-img resize ubuntu.img +100G
	# If the VM has the "cloud-initramfs-growroot" package pre-installed (which is our case),
	# its root partition will be expanded upon next startup.
fi

if [ ! -f user-data.img ]; then
	echo "Create password and configs..."
	echo "=============================="

	cat > user-data << EOF
#cloud-config
password: ubuntu
chpasswd: { expire: False }
ssh_pwauth: True
EOF
	
	cloud-localds user-data.img user-data
	rm user-data

	echo "Config created! Now you can start the VM with run-vm.sh, and ssh into it with ubuntu:ubuntu."
fi

# To allow ssh into the root:
# Change the /etc/ssh/sshd_config file to:
#
# #Authentication
# PermitRootLogin yes
#
