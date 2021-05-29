#!/bin/bash

HOSTNAME=$(hostname)

export DEBIAN_FRONTEND=noninteractive

apt update && apt upgrade

apt-get install -y \
curl \
dnsutils \
git \
nginx \
net-tools \
ufw 

ufw default deny incoming
ufw default allow outgoing

ufw allow ssh/tcp
ufw allow http/tcp
ufw allow https/tcp

ufw enable

rm /var/www/html/index.nginx-debian.html
rm /etc/nginx/sites-enabled/default
touch /var/www/html/index.html

cat <<END >/etc/nginx/sites-enabled/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name ${HOSTNAME};
}
END

systemctl restart nginx.service 
