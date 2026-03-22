#!/bin/bash
<<comment
script_name:nexus_installation_script
script_created_by:Govardhan
comment

#update the system
echo "updating the system"
yum update -y

#install java
echo "installing java"
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-1.8.0-amazon-corretto-devel --nogpgcheck

java -version

#installing nexus in /opt/

cd /opt/

wget https://download.sonatype.com/nexus/3/nexus-3.70.1-02-java8-unix.tar.gz

#unzipping the tar file
tar -zxvf nexus-3.70.1-02-java8-unix.tar.gz

#rename the nexus tar file
mv /opt/nexus-3.70.1-02 /opt/nexus


#installing tree,wget,unzip,tar,git

yum install tree wget unzip git tar -y

#create a dedicated user
useradd nexus
echo 'nexus   ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work

chmod -R 775 /opt/nexus
chmod -R 775 /opt/sonatype-work


