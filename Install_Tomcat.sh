#!/bin/bash
# Install prerequisite packages, install and setup Tomcat.
# Execute this script as the user you wish to configure for Tomcat; the user should have sudo rights.
# Logout and back in after running the script for the user's group addition to take effect.

sudo dnf -y upgrade # Upgrade the server first. If it is not desired to upgrade the server, comment out this line.
sudo dnf -y install wget tree unzip vim java-11-openjdk-devel # Install prerequisite/useful packages.
sudo wget -O "/opt/apache-tomcat-9.0.59.tar.gz" "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.tar.gz" # Download Tomcat from web and save to the specified path.
sudo tar -xvf "/opt/apache-tomcat-9.0.59.tar.gz" # Extract Tomcat archive.
sudo mv "/opt/apache-tomcat-9.0.59" "/opt/tomcat9" # Rename the extracted Tomcat directory.
sudo groupadd tomcat # Add a group for Tomcat users.
sudo usermod -a -G tomcat `whoami` # Assign the user executing this script to the "tomcat" group.
sudo chown -R root:tomcat "/opt/tomcat9" # Change the group ownership of the tomcat directory to "tomcat" group so that only members of this group will have access to this directory.
sudo chmod -R g+rws "/opt/tomcat9" # Set full and special permissions to this directory and sub-directories such that any file created in this directory and deeper inherit the group's permissions.
sudo chmod g+x "/opt/tomcat9/conf" # Add group execute permission to directory.
sudo ln -s "/opt/tomcat9/bin/startup.sh" "/usr/bin/starttomcat" # create a soft link to start Tomcat from anywhere; Type "starttomcat" to start the application.
sudo ln -s "/opt/tomcat9/bin/shutdown.sh" "/usr/bin/stoptomcat" # create a soft link to stop Tomcat from anywhere; Type "stoptomcat" to stop the application.
sudo rm "/opt/apache-tomcat-9.0.59.tar.gz" # Remove the archive from the server.

# The following config. can be added to this script for automatic setup or should be configured manually:
#	1. File /opt/tomcat9/conf/tomcat-users.xml: Add user and role info (add before </tomcat-users>)
#	2. File /opt/tomcat9/conf/server.xml (line 69): Change default port 8080 to something else (optional)
#	3. File /opt/tomcat9/webapps/manager/META-INF/context.xml (line 22-23): Comment out lines that allow local access only to back-end (optional - only necessary if you want to access back-end from web)
#	4. Add cron job for Tomcat to start automatically at server startup (optional)
#	5. Setup access between Maven and Tomcat servers either via ssh or password authentication. Copy the web app from Maven server to
#	   Tomcat server using scp (This is a manual operation; Maven should be able to do this automatically if setup to do so. We did not go over this in class.)
#	6. Start the Tomcat application (Type starttomcat)
