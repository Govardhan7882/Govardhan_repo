#!/bin/bash

<<comment
script_name:maven_installation_script
author:Govardhan
Date:17March2026
comment

# update the system before installing further
 yum update -y

 #install java 21 version

 yum install java-21-openjdk-devel -y

 # install tree, unzip, wget and git

 yum install tree unzip wget git -y

 # Before installing the maven , need to change path to /opt

 cd /opt/

 #installing the maven

 wget https://dlcdn.apache.org/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.zip
 
# unzipping the maven installation zip file

 unzip apache-maven-3.9.14-bin.zip

#Set the class path/Environmental Variable

maven_path="/opt/apache-maven-3.9.14"

echo "" >> ~/.bash_profile
echo "export M2_HOME=$maven_path" >> ~/.bash_profile
echo "export PATH=$PATH:$M2_HOME/bin" >> ~/.bash_profile

# reload the bash_profile file
source ~/.bash_profile

echo "maven enviornment variables added successfully"
echo "M2_HOME=$M2_HOME"


cd /opt/

git clone https://github.com/kkdevopsb8/maven-webapplication-project-kkfunda.git

#########END OF THE SCRIPT#######################################



 
