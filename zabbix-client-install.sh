#!/bin/bash

#Script bash to connect a machine to the Zabbix server

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

#ufw rules
#ufw allow from [Zabbix server IP] to any port 10050 proto tcp



# sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/dstf/debian-lab/main/zabbix-client-install.sh)"
