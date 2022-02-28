#!/bin/bash
echo "please enter the userName of the account you want to creat!"
read userName 
echo "The user's name you entered is:" $userName
sudo useradd $userName 
echo "$userName user account created sucessfully"
echo "set the password for $userName"
 passwd $userName 
