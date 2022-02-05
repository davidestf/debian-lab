#/bin/bash

apt update && apt upgrade

apt-get install -y \
curl \
git \
gnupg2 \
net-tools \
ufw

ufw default deny incoming
ufw default allow outgoing

ufw allow from IPv4 to any port 22
ufw enable


wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
echo "deb http://as-repository.openvpn.net/as/debian buster main">/etc/apt/sources.list.d/openvpn-as-repo.list

apt update && apt -y install openvpn-as

#passwd openvpn


#userlockoout release
#cd /usr/local/openvpn_as/scripts
#./sacli -k vpn.server.lockout_policy.n_fails -v 10 ConfigPut
#./sacli -k vpn.server.lockout_policy.reset_time -v 300 ConfigPut
#./sacli start


# sh -c "$(curl -fsSL https://raw.githubusercontent.com/dstf/debian-lab/main/openvpn.sh)"
