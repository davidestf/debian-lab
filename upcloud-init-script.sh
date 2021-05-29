#!/bin/bash


HOSTNAME=$(hostname)

export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
curl \
dnsutils \
git \
nginx \
net-tools \
ufw \
zsh 

apt update && apt upgrade

ufw default deny incoming
ufw default allow outgoing

ufw allow ssh/tcp
ufw allow http/tcp
ufw allow https/tcp

ufw enable

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

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)


perl -pi -e "s/robbyrussell/spaceship/g" .zshrc 

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" 
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

source ~/.zshrc

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" 
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

source ~/.zshrc

reboot
