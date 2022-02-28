#!/bin/bash
echo "please enter you pin"
read pin
if [ $pin -eq 5470 ]
then
echo "you enter a valid pin"
echo "welcome to TD, how can we help you"
else 
echo "sorry, your pin is invalid. please contact a branch a branch."
fi 
