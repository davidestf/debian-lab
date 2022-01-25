#!/bin/bash

apt-get -y install vsftpd openssl

openssl req -x509 -nodes -days 12000 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/private/vsftpd.pem
chmod 600 /etc/ssl/private/vsftpd.*

read -p "Do you want to update VSFTPD settings? (y/n): " UPDATE
echo
if [ "$UPDATE" == "y" ]; then
echo "listen=YES
listen_port=21
local_root=/home
anonymous_enable=NO
local_enable=YES
write_enable=YES
anon_upload_enable=NO
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=NO
ftpd_banner=Welcome to FTP service.
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key
local_umask=022
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
ssl_ciphers=HIGH
require_ssl_reuse=NO
pasv_enable=YES
pasv_min_port=50000
pasv_max_port=50999


userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO" > /etc/vsftpd.conf

#echo "sammy" | sudo tee -a /etc/vsftpd.userlist

service vsftpd restart
 
fi
