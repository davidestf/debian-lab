#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

HOSTNAME=$(hostname)

# Disabling ICMP
iptables -A INPUT -p icmp --icmp-type echo-request -j REJECT

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

cat <<END >/var/www/html/index.html
NO ACCESS ${HOSTNAME}
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

reboot
