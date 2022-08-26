#!/bin/bash

## Author - Suborna Nath
## Date - August 17th, 2022

########### Description 
## This script will help the user add and commit any changes to git & push to GitHub.
## It will make sure the user is not on the main branch and let the user know if they are.
## It will help the prompt the user to switch branch if in the main.
## Next, it will check for any changes to files and if so, it will check for any sensitive information like SSN & phone number
## If there are any sensitive information, the script will let the user know and exit.
## If not, the script will prompt the user to add and commit changes and push to GitHub

## Bugs 
# We assume the user didnt make any changes in the main branch, if there are, the script might break
# if main branch names are not main, master, or origin, the code might break

#########################################################################
############################## Start of Script ##########################
#########################################################################


################# 1st step - check if we are in a git repo

## This conditional statement will check if we are in a git repo. 
## If not, we will exit out of the script
if [[ $(ls -a | grep ^".git") == ".git" ]]
then
echo ""
echo "Its a git repository!"
echo ""
else
echo ""
echo "you need to be in a git repository!"
exit 1
fi

################# 2nd step - check if user is in the main/master/origin branch

## Checking if we are in the main branch
## We will prompt the user to switch branch, if they are in the main branch
if [[ "main master origin" == *"$(git branch --show-current)"* ]]
then 
echo "!!!You are in the main branch!!!"
echo ""
read -p "Do you want to switch to a different branch? [Y/n] >> " input1

# If the user wants to switch branch -> asking user for the branch name
if [[ $input1 == [Yy] ]]
then
echo ""
echo -e "List of current branches ->" 
git branch
read -p "Which branch do you want to switch to? >> " input2

# If the branch name is valid -> switching branch
    if [[ $(git branch | rev | cut -d " " -f 1 | rev | grep $input2) == $input2 ]]
    then 
    echo "Switching to branch $input2"
    git switch $input2
# If branch name is NOT valid -> exiting the script
    else
    echo "Invalid branch name!!"
    exit 1
    fi
# if the user does NOT want to switch branch -> existing the script
else
echo "Commits are NOT allowed in the MAIN branch!!"
exit 1
fi
# This will trigger if the user is already in a branch other than main
else
echo "You are NOT in the main branch. Awesome!!"
fi

echo "______________________________________________"


####################### 3rd step - checking if there are any changes to any files

# checking git status and storing as a variable
status=$(git status -s | rev | cut -d " " -f 1 | rev)

# Looking for any changes
# If status is clean
if [[ -z $status ]] 
then echo "You have NOT made any changes to your file(s)."
echo "______________________________________________"
git status
exit 0
# If git status has pending files -> triggers if statement on line 117
else
git status
echo "______________________________________________"
echo "You have made changes to these files -->" $status
echo "______________________________________________"
fi

# if the else statement on line 90 got triggiered, it means we have files to commit
# We will print the following statement
echo "Let's check for any sensitive information in the files..."
echo "______________________________________________"

####################### 4th Step - checking for sensitive information in the files

## Patterns to check for in all the files that need commits
pattern1="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" # 123456789 = SSN
pattern2="[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]" # 123-45-6789 = SSN
pattern3="([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" # (123)456-7890 = Phone number
pattern4="[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" # 123-456-7890 = Phone number


# Saves file names that need to be committed
list=$(git status -s | rev | cut -d " " -f 1 | rev)

### If we have more than one file -> if statement will trigger
if [[ $(echo "$list" | wc -w) -gt 1 ]]
then
# This is a nested for loop. We are looping through each file that needs to be commited
# For every file, we are checking 4 patterns on line 107-110
# If there is a match, we let the user know & exit the script
    for file in "$list"
    do
# We are looping each pattern 
        for ((i=1; i<5; i++))
        do
# saving the pattern names in a variable
        patternVar="pattern$i" 
        patternVar=$(echo "${!patternVar}")

# Looking for a match of the pattern and saving it
        check=$(cat $file | grep "$patternVar")
# If there was no match -> if statement will trigger -> then skip to line 172
        if [[ $check == "" ]] #  no pattern match
        then
        unset $check # deleting the variable for next loop
        unset $patternVar # deleting the variable for next loop
# If there is a match -> else will trigger & exit the script
        else
        echo -e "> $file contains sensitive information. \n Please edit the file and delete the info before commiting."
        exit 1
        fi 
        done
    done
### Else there is only one file to commit -> else statement will trigger
else 
# Checking for pattern match on line 107-110
    for ((i=1; i<5; i++))
    do
# saving the pattern names in a variable
    patternVar="pattern$i"
    patternVar=$(echo "${!patternVar}")
# checking for any pattern match and saving in a variable
    check=$(cat "$list" | grep "$patternVar")
# If there are no match -> If statement will trigger -> then skip to line 172
        if [[ $check == "" ]] 
        then
        unset $check # deleting the variable for next loop
        unset $patternVar # deleting the variable for next loop
# Else there is a match, we let the user know & exit the script
        else
        echo -e "> $list contains sensitive information. \nPlease edit the file and delete the info before commiting."
        exit 1
        fi 
    done
fi

####################### 5th Step - Add, Commit and Push to Github

## Checking git status
# if all the checks are done and there are changes, we prompt the user to decide whether to stage and commit
if [[ $(git status | grep "nothing to commit") != "nothing to commit" ]] 
then
read -p "The files are ready to be staged & commited! Are you ready to commit the changes? [Y/n] >> " response1
# If user replies yes -> we ask for a commit message
    if [[ $response1 == [Yy] ]]
    then
    read -p "Please enter your commit message here >> " response2
    echo "______________________________________________"
        if [[ -n $response2 ]] # response is not empty
        then
        git add .
        git commit -m "$response2"
        else
        echo "You did not add a commit message! Exiting the script."
        exit 1
        fi
        echo "______________________________________________"
# Else user replies no, we exit the script
    else
    echo "______________________________________________"
    echo "Thank you! Run the script when you are ready to commit your changes."
    echo "______________________________________________"
    exit 0
    fi
# If working tree is clean, we print git status & exit the script
else
git status
exit 0
fi

# Prompting user to push changes to GitHub afte stage & commit
read -p "Do you want to push any changes to the GitHub? [Yy] >> " response3
# If response is yes, we push the changes to GitHub
if [[ $response3 == [Yy] ]]
then
echo "Pushing the changes to GitHub..."
echo "______________________________________________"
git push origin "$(git branch --show-current)"
# If response is no -> we exit the script
else
echo "Changes were NOT pushed to Github!"
exit 0
fi

# We check if the push was successful or not and let the user know
if [[ $(echo $?) == 0 ]]
then
echo "______________________________________________"
echo "All the changes were pushed to github. Exiting now!"
echo "______________________________________________"
else
echo "Something went wrong!"
fi

########################## END OF SCRIPT #############################