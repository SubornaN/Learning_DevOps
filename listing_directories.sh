#!/bin/bash

# Author - Suborna Nath
# Date - Septemeber 12, 2022
# Objective - To understand how to write and execute a basic bash script
# Description - Write a script for printing all file related information in present working directory 

# printing the working directory
echo "Current Working Directory--> " && pwd
echo "_____________________________________________________"
echo ""

# listing all files and sub-directories in the current working directoy
# -l = lists all the details such as user, group, permissions, size, date last modified, name
# -t = sorts by time last a file or directory was modified
# -h = prints size with K, M, G instead of the long format
# -F = appends a / at the end of all directories in the list 

ls -lthF
