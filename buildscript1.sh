#!/bin/bash

# Name = Suborna Nath
# Date = August 5, 2022

############################## Description ############################
# This is a software management script that will auto-update the server
# on this system every week on Friday at 11 pm. 
# After every update, there will be file created that will contain the 
# log on what was updated. The file will be saved in the root directory. 

# Crontab Syntax = 0 23 * * 5 root /buildscript1.sh
# ----------------------------------------------------------------------

# command to update the repository
sudo /usr/bin/apt update >> /testfile_$(date +"%m%d%y").log 
# command to upgrade the server
sudo /usr/bin/apt upgrade -y >> /testfile_$(date +"%m%d%y").log
