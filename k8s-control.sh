#!/bin/bash

# sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/dstf/debian-lab/main/k8s-control.sh)"


#set the variables 

#hostname=$hostname 
user="admin_user"
controlipv4="$ipv4"
worker1ipv4="$ipv4"
worker2ipv4="$ipv4"


#sudo hostnamectl set-hostname k8s-control


cat <<END >>/etc/hosts
$controlipv4 k8s-control
$worker1ipv4 k8s-worker1
$worker2ipv4 k8s-worker2
END

systemctl restart systemd-hostnamed

adduser $user
usermod -aG sudo $user


cat << EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF


sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

sudo apt-get update && sudo apt-get install -y containerd

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

sudo swapoff -a

sudo apt-get update && sudo apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.24.0
mkdir -p /home/$user/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/$user/.kube/config
sudo chown $(id -u):$(id -g) /home/$user/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

kubeadm token create --print-join-command

#copy the result to the worker node 
#sudo kubeadm join ...

#kubectl get nodes
