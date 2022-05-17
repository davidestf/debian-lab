#!/bin/bash


curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer

# CentOS
#sudo yum install -y yum-utils
#sudo yum-config-manager --add-repo \
#https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
#sudo yum -y install packer
