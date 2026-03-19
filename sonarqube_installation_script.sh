#!/bin/bash

<<comment
script_name:sonarqube installation script
created by:Govardhan
comment

#Fix time sync - to avoid gpg errors
timedatectl set-ntp true
timedatectl set-timezone UTC
systemctl restart chronyd || systemctl restart systemd-timesyncd
timedatectl   # Confirm NTP is synchronized

# install Java17
echo "installing java17"
rpm --import https://yum.corretto.aws/corretto.key
curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
yum install -y java-17-amazon-corretto-devel --nogpgcheck

#set required kernal parameters
sysctl -w vm.max_map_count=262144
echo 'vm.max_map_count=262144' >> /etc/sysctl.conf

#install git tree wget unzip -y
yum install git tree wget unzip -y

#download and extract sonarqube

cd /opt/

wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip

unzip sonarqube-9.6.1.59531.zip

rm -rf sonarqube-9.6.1.59531.zip

mv sonarqube-9.6.1.59531 sonarqube

#create a dedicated user
useradd sonar
echo 'sonar   ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
chown -R sonar:sonar /opt/sonarqube
chmod -R 775 /opt/sonarqube


###############################end of the script#################################


