#!/bin/bash

cd /tmp
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+debian11_all.deb
dpkg -i zabbix-release_6.0-1+debian11_all.deb
apt update
apt upgrade -y
apt install zabbix-agent -y
read -p "What is Zabbix server address ?
" host
sed -i "s/Server=127.0.0.1/Server\=$host/" /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent.service




# sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/dstf/debian-lab/main/zabbix-client-install.sh)"
