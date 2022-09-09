#!/bin/bash

#variable
#IPv4=

apt-get update && apt-get upgrade
apt-get install squid

cp /etc/squid/squid.conf /etc/squid/squid.conf.default

echo -e "acl client src $IPv4 \nhttp_access allow client" >> /etc/squid/squid.conf


ufw allow 3128/tcp
#iptables -I INPUT -p tcp --dport 3128 -j ACCEPT


systemctl restart squid
