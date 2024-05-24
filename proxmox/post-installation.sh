#!/bin/bash

sed -i 's/^\([^#].*\)/# \1/g' /etc/apt/sources.list.d/pve-enterprise.list

echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list

apt update && apt dist-upgrade -y && apt autoremove --purge -y

echo "Installing packages"
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"

apt-transport-https 
ca-certificates 
curl 
software-properties-common

curl
hdparm
ifupdown2
logrotate
lsof
lsscsi
net-tools
rsync
screen
sdparm
sysstat
smartmontools
tcpdump
EOF
)


#packer & terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/hashicorp.gpg
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt update && apt install packer terraform

#ansible
apt-add-repository ppa:ansible/ansible
apt update && apt install ansible
