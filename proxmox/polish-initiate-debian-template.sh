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

#template polish
truncate -s 0 /etc/machine-id 
rm  /var/lib/dbus/machine-id 
ln -s /etc/machine-id /var/lib/dbus/machine-id



#standard system utilities packages 
while read -r p ; do apt-get install -y $p ; done < <(cat << "EOF"
    apt-listchanges
    lsof
    mlocate
    w3m
    at
    libswitch-perl
    xz-utils
    telnet
    dc
    bsd-mailx
    file
    exim4-config
    m4
    bc
    dnsutils
    exim4
    python2.7
    openssh-client
    aptitude
    bash-completion
    python
    host
    install-info
    bzip2
    reportbug
    krb5-locales
    bind9-host
    time
    info
    liblockfile-bin
    whois
    aptitude-common
    patch
    ncurses-term
    mutt
    mime-support
    exim4-daemon-light
    ftp
    nfs-common
    python-reportbug
    rpcbind
    texinfo
    python-minimal
    procmail
    libclass-isa-perl
    python-apt
    python-support
    exim4-base
    debian-faq
    doc-debian

EOF
)
apt clean
apt autoremove
