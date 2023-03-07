#!/bin/bash

#add-repository

cat <<END >/etc/apt/source.list
deb http://deb.debian.org/debian bullseye main  contrib
deb-src http://deb.debian.org/debian/ bullseye main  contrib

deb http://security.debian.org/debian-security bullseye-security main contrib #non-free
deb-src http://security.debian.org/debian-security bullseye-security main contrib #non-free
END

#update
apt update && apt upgrade
apt instll cloud-init

#delete user
deluser --remove-all-files $user

#template polish
cd /etc/ssh
rm ssh_host_*

truncate -s 0 /etc/machine-id 
rm  /var/lib/dbus/machine-id 
ln -s /etc/machine-id /var/lib/dbus/machine-id



#standard system utilities packages 
while read -r p ; do apt-get install -y $p ; done < <(cat << "EOF"
        apt-listchanges
    aptitude
    aptitude-common
    at
    bash-completion
    bc
    bind9-host
    bsd-mailx
    build-essential 
    bzip2
    dc
    debian-faq
    dnsutils
    doc-debian
    exim4
    exim4-base
    exim4-config
    exim4-daemon-light
    file
    ftp
    git
    hdparm
    host
    info
    install-info
    krb5-locales
    libclass-isa-perl
    liblockfile-bin
    libswitch-perl
    lm-sensors
    lshw
    lsof
    m4
    mime-support
    mlocate
    mutt
    ncurses-term
    nfs-common
    openssh-client
    parted
    patch
    procmail
    python
    python-apt
    python-minimal
    python-reportbug
    python-support
    python2.7
    reportbug
    rpcbind
    telnet
    texinfo
    time
    zsh
    w3m
    whois
    xz-utils

EOF
)
apt clean
apt autoremove
