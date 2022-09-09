#!/bin/bash

if [ ! -f ubuntu.img ]; then
	echo "Download ubuntu cloud image..."
	echo "==============================="
	curl https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img -o ubuntu.img

	echo "Resize the image to a larger size..."
	echo "===================================="
	qemu-img resize ubuntu.img +100G
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
fi


