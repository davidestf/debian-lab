#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

HOSTNAME=$(hostname)

# Install software
apt-get install -y \
curl \
dnsutils \
git \
nginx \
net-tools \
ufw \
zsh 

# System Updates
apt update && apt upgrade

# Configure firewall 
ufw default deny incoming
ufw default allow outgoing

ufw allow ssh/tcp
# or 
# ufw allow from 0.0.0.0 to any port 22
ufw allow http/tcp
ufw allow https/tcp

ufw enable

# Configure WebServer
rm /var/www/html/index.nginx-debian.html
rm /etc/nginx/sites-enabled/default

# Self-SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
openssl dhparam -out /etc/nginx/dhparam.pem 4096

cat <<END >/var/www/html/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Hello World - App X <!-- Replace 'X' with '1' or '2' as appropriate --></title>
        <link href="https://06a7f2c2-5c56-40d7-aded-6455af08391b.es-mad1.upcloudobjects.com/project001/fixerupper/fixerupperlogo.png"" rel="icon" type="image/png" />
        <style>
            body {
                margin: 0px;
                font: 20px 'RobotoRegular', Arial, sans-serif;
                font-weight: 100;
                height: 100%;
                color: #0f1419;
            }
            div.info {
                display: table;
                background: #e8eaec;
                padding: 20px 20px 20px 20px;
                border: 1px dashed black;
                border-radius: 10px;
                margin: 0px auto auto auto;
            }
            div.info p {
                display: table-row;
                margin: 5px auto auto auto;
            }
            div.info p span {
                display: table-cell;
                padding: 10px;
            }
            img {
                width: 176px;
                margin: 36px auto 36px auto;
                display:block;
            }
            div.smaller p span {
                color: #3D5266;
            }
            h1, h2 {
                font-weight: 100;
            }
            div.check {
                padding: 0px 0px 0px 0px;
                display: table;
                margin: 36px auto auto auto;
                font: 12px 'RobotoRegular', Arial, sans-serif;
            }
            #footer {
                position: fixed;
                bottom: 36px;
                width: 100%;
            }
            #center {
                width: 400px;
                margin: 0 auto;
                font: 12px Courier;
            }
        </style>

    </head>

    <body onload="checkRefresh();">
        <img alt="Fixerupper Logo" src="https://06a7f2c2-5c56-40d7-aded-6455af08391b.es-mad1.upcloudobjects.com/project001/fixerupper/fixerupperlogo.png"/>
        <div class="info">
            <p><span>Server name:</span> <span>server_hostname</span></p>
            <p><span>Server address:</span> <span>server_address</span></p>
            <p class="smaller"><span>User Agent:</span> <span>client_browser</span></p>
            <p class="smaller"><span>URI:</span> <span>server_url</span></p>
            <p class="smaller"><span>Doc Root:</span> <span>document_root</span></p>
            <p class="smaller"><span>Date:</span> <span>server_date</span></p>
            <p class="smaller"><span>Client IP:</span> <span>proxied_for_ip</span></p>

        </div>

        <div id="footer">
            <div id="center" align="center">
                Request ID: request_id<br/>
                © fixerupper.me
            </div>
        </div>
    </body>
</html>

END


cat <<END >/etc/nginx/sites-enabled/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;
        server_name ${HOSTNAME};
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;
    root /var/www/html;
    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;
    server_name ${HOSTNAME};
END

cat  <<\EOF >>/etc/nginx/sites-enabled/default
    sub_filter_once off;
    sub_filter 'server_hostname' '$hostname';
    sub_filter 'server_address'  '$server_addr:$server_port';
    sub_filter 'server_url'      '$request_uri';
    sub_filter 'remote_addr'     '$remote_addr:$remote_port';
    sub_filter 'server_date'     '$time_local';
    sub_filter 'client_browser'  '$http_user_agent';
    sub_filter 'request_id'      '$request_id';
    sub_filter 'nginx_version'   '$nginx_version';
    sub_filter 'document_root'   '$document_root';
    sub_filter 'proxied_for_ip'  '$http_x_forwarded_for';
}
EOF

cat <<END >/etc/nginx/snippets/self-signed.conf
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
END

cat <<END >/etc/nginx/snippets/ssl-params.conf
ssl_protocols TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;
ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
ssl_session_timeout  10m;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off; # Requires nginx >= 1.5.9
ssl_stapling on; # Requires nginx >= 1.3.7
ssl_stapling_verify on; # Requires nginx => 1.3.7
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
# Disable strict transport security for now. You can uncomment the following
# line if you understand the implications.
# add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
END

systemctl restart nginx.service 


# Install ZSH
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

perl -pi -e "s/robbyrussell/spaceship/g" ~/.zshrc

chsh -s $(which zsh)

ln -sf ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme

source ~/.zshrc

# Disabling ICMP
iptables -A INPUT -p icmp --icmp-type echo-request -j REJECT

reboot
