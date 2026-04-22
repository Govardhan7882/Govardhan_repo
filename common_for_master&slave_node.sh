#!/bin/bash

: <<'comment'
script_usage: common script for both master and slave node
runwith: root user
comment


#1)Disable swap & add kernel settings

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#2)Add  kernel settings & Enable IP tables(CNI Prerequisites)-Communication b/w POD to POD

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF


modprobe overlay
modprobe br_netfilter



cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF


sysctl --system

#3)Install containerd run time

apt-get update -y 
apt-get install ca-certificates curl gnupg lsb-release -y


# Add Docker’s official GPG key:
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#Use follwing command to set up the repository:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  
# Install containerd

apt-get update -y
apt-get install containerd.io -y

# Generate default configuration file for containerd

####Note: Containerd uses a configuration file located in /etc/containerd/config.toml for specifying daemon level options.
#####The default configuration can be generated via below command.

containerd config default > /etc/containerd/config.toml

# Run following command to update configure cgroup as systemd for contianerd.

sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service

systemctl restart containerd
systemctl enable containerd


#4)Installing kubeadm, kubelet and kubectl

## Update the apt package index and install packages needed to use the Kubernetes apt repository:

apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key:



curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes apt repository:



echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list



# Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

apt-get update
apt-get install -y kubelet kubeadm kubectl

# apt-mark hold will prevent the package from being automatically upgraded or removed.
apt-mark hold kubelet kubeadm kubectl


# Enable and start kubelet service

systemctl daemon-reload 
systemctl start kubelet 
systemctl enable kubelet.service


apt update
apt install -y conntrack
which conntrack
conntrack -V



##==========End of the script ====##




