#!/bin/bash

# Name - Suborna Nath
# Date - August 11, 2022

# Description
## This is an interactive script. At first, a snapshot of the top 5 processes
## using the most memory will be created. If the memory
## usage exceed 300MB, the user will be prompted to decide whether
## to kill or continue running the process.
## Next, the user can decide whether to continue running the script. If yes,
## another snapshot will a created after 30 seconds & the steps will be repeated.
## If not, the user will exit out of the script.

# Bug
## If the top process changes after I take the snap or save the process ID  
## on line 28, my script won't recognize or notify the user about it. It will 
## use the process ID saved as a variable and prompt the user to terminate that process. 
## Also, the script will continue running until we recive a response from the user to exit.

# Note
## We need to install 'smem' for the script to run -> "sudo apt install smem"

#################################################################
#################################################################

# The loop will run every 30 seconds unless the condition turns false
while true
do
echo "Here is a snapshot of your top 5 processes [RSS = bytes]"
echo "------------------------------------------"
smem -c "pid command rss" -s rss -r | head -n 6
echo "------------------------------------------"

    # Here we are checking if the memory usage is above 300MB for the top process
    if [[ $(smem -H -c "rss" -s rss -r | head -n 1) > 300000 ]] 
    then 
    processID=$(smem -H -c "pid" -s rss -r | head -n 1) # storing the process ID for termination
    echo "The memory usage is high (>300MB) for Process ID $processID"
    echo "------------------------------------------"

        # If the usage is above 300MB, the user can decide what to do with the process
        read -p "Would you like to kill the process? If Yes, type [Y]. If No, press [Enter] " input
            if [[ $input = [Yy] ]]
            then
                kill -9 $processID
                echo "Status: killed | Process ID $processID"
                echo "------------------------------------------"
            else
                echo "Status: running | Process ID $processID"
                echo "------------------------------------------"
            fi
    else
    echo "Your memory usage is below the threshold (<300MB)"
    echo "------------------------------------------"
    fi

    # The user can decide to continue running the script or exit out of it
    read -p "Do you want to continue the script? If Yes, type [Y]. To Exit, press [Enter] " input2
    if [[ $input2 = [Yy] ]] 
    then
        echo "Creating another snapshot after 30 seconds..."
        echo " "
        echo "##########################################"
    else
        exit 0
    fi
    
sleep 30
done