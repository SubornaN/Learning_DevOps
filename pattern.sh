#!/bin/bash 

# Author - Suborna Nath
# Date - September 12, 2022
# Description - read a input from user and create a pattern as 1 12 123 ... 123...n
# n = user input


read -p  "Enter a number --> " input

declare -A list # creating an array
declare -i num=1 # creating a integer variable

while [[ $num -le $input ]]
do 
list+=$num # apppend the value to the array
echo ${list[*]}
num+=1
# echo $num
# echo "--------------"
done