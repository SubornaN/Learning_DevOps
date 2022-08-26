#!/bin/bash 

## Author - Suborna Nath
## Date - August 17th, 2022

########### Description 
## This script will create a user and add it to a group. 
## The user has to define the username and group name.
## It will create an user only if the user does not exist.
## It will create the user group if it is not already created.
## If the user exists or group already exists, those will not be created. 
## If the group already exists, it will add the user to the group.
## The user shell will be the default shell set by their system.

## Username & Group Naming Criteria ------>
## Username and group both must start with 3 letters, numbers are allowed. 
## No special characters!

########### Bugs
## If username or group has 2 or more words with any spaces in between, the script might break.
## If the username/group are already created, the script does not check if the user is assigned to the group. It will reassign the user to the specified group!

##############################################################################
######################### SCRIPT STARTS AT LINE 95 ###########################
##############################################################################


############## 3rd step - Running the function to check criteria and create the user and group accordingly

### Defining a function 
# This function will be triggered on line 130 or line 148 if proper inputs are met. 
# Here we are creating a user and handing situations
# where the user, usergroup might already exists

createUser () {
    echo ""
    echo "Thank you! Checking if username meets the criteria..."
    echo ""

    # Creating a pattern to match the criteria ->  1st 3 characters must be letters. 
    # Only letters and numbers allowed
    pattern="^[a-zA-Z][a-zA-Z][a-zA-Z][[:alnum:]]*$"

## These following conditional statements will make sure username and group name critetia are meet
## Also, they will create the user and group accordingly
## if username or group does not meet criteria -> 1st 3 characters must be letters, no special characters
    if [[ $(echo $newUser | grep $pattern) != $newUser ]] | [[ $(echo $newGrp | grep $pattern) != $newGrp ]]
    then 
    # Exiting the script since names don't meet the criteria
    echo -e "The username or group does not meet the criteria. \nPlease try running the script again!"
    exit 1
## if username meets criteria
    else
## if username exists
## usergroup does not exist
        if [[ $checkUsr == $newUser ]] && [[ $checkGrp != $newGrp ]]
        then
        # creating the group and adding user to the group
        echo -e "The username already exists but user group does not exist. \nAdding $newUser to group $newGrp. "
        echo""
        groupadd $newGrp # create group
        usermod -aG $newGrp $newUser # add existing user to the new group
        echo -e "User Name: $(id -nu $newUser) \nGroup Name: $(id -nG $newUser) \nShell Name: $SHELL"
## username exists
## usergroup exists
        elif [[ $checkUsr == $newUser ]] && [[ $checkGrp == $newGrp ]]
        then
        # Only adding user to the group
        echo -e "The username and user group already exists. \nAdding $newUser to group $newGrp"
        echo ""
        usermod -aG $newGrp $newUser # add existing user to the existing group
        echo -e "User Name: $(id -nu $newUser) \nGroup Name: $(id -nG $newUser) \nShell Name: $SHELL"
## username does not exist
## usergroup does not exist
        elif [[ $checkUsr != $newUser ]] && [[ $checkGrp != $newGrp ]]
        then
        # creating both user and group and adding user to the group
        echo -e "The username and usergroup does not exist. \nCreating user $newUser and adding to new group $newGrp"
        echo ""
        groupadd $newGrp # create group
        useradd -m $newUser -g $newGrp # create user and add to new group
        echo -e "User Name: $(id -nu $newUser) \nGroup Name: $(id -nG $newUser) \nShell Name: $SHELL"
## username does not exist
## usergroup exists
        else
        # creating only user and adding to the group
        echo -ee "The username does not exist but the usergroup exists. \nCreating $newUser and adding to $newGrp"
        echo ""
        useradd -m $newUser -g $newGrp # create user and add to group
        echo -e "User Name: $(id -nu $newUser) \nGroup Name: $(id -nG $newUser) \nShell Name: $SHELL"
        fi
    fi
}

#########################################################################
############################## Start of Script ##########################
#########################################################################

############## 1st step - Make sure the user is a root user

# Checking if the user is a root user
if [[ $UID != 0 ]]
then 
echo "You need to be a ROOT USER to create another user account. Try running the script with 'sudo' command!"
exit 1
else 
echo "You are a root user! Let's create the account!"
echo ""
fi

############## 2nd step - Making sure the user provided proper input to create the user and group

## Printing the requirements for the username
echo -e "Username Criteria >> \n1-The username and user group must start with letters as the 1st 3 characters.\n2-Numbers are allowed.\n3-No special characters."
echo "-------------------------------------------"
read -p "Please enter the new username >> " newUser
read -p "Please enter the new group >> " newGrp


## Checking if the user provided an input. They will be given 2 attempts to provide a username.

# 1st attempt -> if username & group are NOT empty
if [[ -n $newUser ]] && [[ -n $newGrp ]]
then 
# Creating variables to check for username, group 
# These variables will be used in the function createUser()
checkUsr=$(ls /home | grep ^"$newUser"$)
checkGrp=$(cut -d ":" -f 1 /etc/group | grep ^"$newGrp"$)

createUser # calling the function to create the user

# 1st attempt -> if username or group is empty
else
echo "----------------------------------------"
# We will prompt the user to try again
echo -e "You did not enter a username OR group\n"
read -p "Enter the new username >> " newUser
read -p "Enter the new group name >> " newGrp

# 2nd attempt -> username and group are NOT empty 
    if [[ -n $newUser ]] && [[ -n $newGrp ]]
    then
    # Creating variables to check for username, group 
    # These variables will be used in the function createUser()
    checkUsr=$(ls /home | grep ^"$newUser"$)
    checkGrp=$(cut -d ":" -f 1 /etc/group | grep ^"$newGrp"$)

    createUser # calling the function to create the user

# 2nd attempt -> username OR group is empty -> Exiting the script
    else
    echo "-------------------------------"
    echo -e "You did not enter a valid username OR group! \nWe can not create the account. \nPlease try running the script again!"
    exit 1 
    fi
fi

########################## END OF SCRIPT #############################