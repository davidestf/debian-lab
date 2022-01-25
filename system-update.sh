#!/bin/sh
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
apt-get autoclean -y && apt-get clean -y
apt-get autoremove
