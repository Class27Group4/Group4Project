#!/bin/bash
# Install prerequisite packages, install and setup Tomcat.
# Execute this script as the user you wish to configure for Tomcat; the user should have sudo rights.
# Logout and back in after running the script for the user's group addition to take effect.

sudo dnf upgrade #If it is not desired to upgrade the server, comment out this line.
sudo dnf install wget tree unzip vim java-11-openjdk-devel
sudo wget -O /opt/apache-tomcat-9.0.59.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.tar.gz
sudo tar -xvf /opt/apache-tomcat-9.0.59.tar.gz
sudo mv /opt/apache-tomcat-9.0.59 /opt/tomcat10
sudo groupadd tomcat
sudo usermod -a -G tomcat `whoami`
sudo chown -R root:tomcat /opt/tomcat10
# create soft links to start/stop tomcat. Type "starttomcat" or "stoptomcat" from anywhere to start or stop tomcat respectively.
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
sudo rm /opt/apache-tomcat-9.0.59.tar.gz

# The following config. can be added to this script for automatic setup or should be configured manually:
#       1. File /opt/tomcat9/conf/tomcat-users.xml: Add user and role info (add before </tomcat-users>)
#       2. File /opt/tomcat9/conf/server.xml (line 69): Change default port 8080 to something else (optional)
#       3. File /opt/tomcat9/webapps/manager/META-INF/context.xml (line 22-23): Comment out lines that allow local access only to
#               back-end (optional - only necessary if ypu want to access back-end from online)
#       4. Add cron job for Tomcat to start automatically at server startup
#       5. Setup access between Maven and Tomcat servers either via ssh or password authentication. Copy web app from Maven server to
#               Tomcat server (This is a manual operation; Maven should be able to do this automatically if setup)
#       6. Start Tomcat application


