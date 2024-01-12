#!/bin/bash


codename=$(lsb_release -cs);echo "deb http://deb.debian.org/debian $codename-backports main contrib non-free"|sudo tee -a /etc/apt/sources.list && sudo apt update
apt install linux-headers-amd64;sudo apt install -t bullseye-backports zfsutils-linux



