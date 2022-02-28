#!/bin/bash
echo "please enter a number"
read num1
echo "please enter another number"
read num2
if [ $num1 == $num2 ]
then 
echo "$num1 is equal to $num2"
else 
echo "$num1 is not equal to $num2"
fi 
