#!/bin/bash

# greeting the user
echo "Welcome to the weather station!"
# prompting the user to decide what data to collect -> forecast or historical
echo -e "What data would you like to collect? [select a number]\n1-Weather Forecast\n2-Historical Data"
# reading the response
read -p "Enter your response >> " response
echo ""

# if-else statement to prompt user for more inputs based on previous selection
if [[ $response == 1 ]]
then
echo ">> Forecast Data <<"
echo ""
read -p "Number of days for forecast (max 7) >> " days
read -p "Type in the Zipcode or City >> " location

# saving user inputs in a file to use in the GET request
echo -e "$response\n$days\n$location" > ./params.txt # the file will be saved where you run the script

elif [[ $response == 2 ]]
then
echo ">> History Data on Weather <<"
echo ""
read -p "Enter the Start Date [yyyy-mm-dd] >> " start
read -p "Enter the End Date [yyyy-mm-dd] >> " end
read -p "Enter the Zipcode or City >> " location

# saving user inputs in a file to use in the GET request
echo -e "$response\n$start\n$end\n$location" > ./params.txt

else
echo "Invalid Response. Please try again! Exiting the script."
fi