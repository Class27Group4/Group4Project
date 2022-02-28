#!/bin/bas
#you should be root user or have sudo righ to execute 
echo -n "enter username"
read username 
echo -n "enter password"
read -s password
sudo adduser $username
echo "$password" | sudo passwd "$username" --stdin
echo "$username welcome to greatness" 

