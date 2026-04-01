#!/bin/bash

<<comment
script_name:tomcat_installation_script
author:Govardhan
date:17march2026
comment

#update the system
echo "upadting the system"

yum update -y

# install the java
echo "installing the java"

yum install java-21-openjdk-devel -y
#install tree,git,wget, unzip
echo "installing the tree, wget,,git and unzip"
yum install tree wget git unzip -y

cd /opt/

# downloading the tomcat zip file using the wget command

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.115/bin/apache-tomcat-9.0.115.zip

#unzipping the file
echo "unzipping the zip file"
unzip apache-tomcat-9.0.115.zip

#removing the zip file 
echo "remvoing the zip file"

rm -rf apache-tomcat-9.0.115.zip

# updating the execute permissions for start and stop shell scripts
cd /opt/apache-tomcat-9.0.115/bin
chmod u+x *.sh

###################end of the script #################################################################

