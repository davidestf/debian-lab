#!/bin/bash

sudo apt -y install qemu-kvm libvirt-daemon  bridge-utils virtinst libvirt-daemon-system
sudo modprobe vhost_net 

#lsmod | grep vhost

echo vhost_net | sudo tee -a /etc/modules

sudo apt -y install virt-top libguestfs-tools libosinfo-bin  qemu-system virt-manager


nano /etc/network/interfaces

# Bridge definitions
auto br1
iface br1 inet static
bridge_ports ens33
bridge_stp off
address 172.16.54.149
network 172.16.54.0
netmask 255.255.255.0
broadcast 172.16.54.255
gateway 172.16.54.2
dns-nameservers 172.16.54.2


sudo virt-install \
--name deb11 \
--ram 2048 \
--vcpus 2 \
--disk path=/var/lib/libvirt/images/deb11-vm.qcow2,size=20 \
--os-type linux \
--os-variant debian9 \
--network bridge=br1 \
--graphics none \
--console pty,target_type=serial \
--location 'http://ftp.debian.org/debian/dists/bullseye/main/installer-amd64/' \
--extra-args 'console=ttyS0,115200n8 serial'
