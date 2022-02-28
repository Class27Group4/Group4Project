i#!/bin/bash
echo "enter the user's name you want to create"
read name 
echo "the user name you entered is" $name
sudo adduser $name
echo "$name enter you password"
read password
sudo passwd $name
echo "$name welcome to the greatness"
