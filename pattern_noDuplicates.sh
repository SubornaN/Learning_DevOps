#!/bin/bash 

# Author - Suborna Nath
# Date - September 12, 2022
# Description - read input from the user and create a pattern as 1 23 456 ...n
# n = user input


read -p  "Enter a number --> " input

declare -a list # creating an array to save all values from 1 to input

# this will add all the numbers to the list
for i in $(seq $input)
do
list[$i]=$i
i+=1
done

echo "Array:" ${list[@]:1:$input} # printing the array
echo "length of Array:" ${#list[@]} # printing the length of array

declare -i index=1 # index value to use for every iteration 
declare -i element=1 # number of elements to collect every iteration

# Until the index is equal to or less than the input, we will continue the loop
while [[ $index -le $input ]]
do
echo ${list[@]:$index:$element} # slicing the array and printing
index+=$element # changing the index value for next iteration
element+=1 # changing the number of elements to print for the next iteration
done