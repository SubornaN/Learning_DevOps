# Author - Suborna Nath
# Date - September 15, 2022
# Description - The purpose of this script is to send a GET request to Visual Crossing Weather to collect weather data.
# The data can be historical or forecast. 
# The user will be prompted to pick a range of date for historical data and a zipcode.
# The user will provide number of days and zipcode for the forecast data.


import requests, subprocess, os.path # importing the modules

# running the bash script in Python
subprocess.run(["./buildscript4.sh"])

#  Handling error: if any error occurs, the except statement on line 54 will trigger
try: 
    if (os.path.exists("./config.txt")): # checking if config file exists

        # saving the user inputs from the bash script in a text file to use with python
        with open('./config.txt','r') as f:
            lines = f.readlines()

        # taking the data from the file and making it into a list
        list=[]
        for line in lines:
            list.append(line.strip())


        # if-else statement to do API call based on user selection: forecast data or historical data
        if list[0] == "1": # forecast data
            url = "https://visual-crossing-weather.p.rapidapi.com/forecast"
            querystring = {"aggregateHours":"24","forecastDays":list[1],"location":list[2],"contentType":"csv","unitGroup":"us","shortColumnNames":"true"}

        else: # historical data
            url = "https://visual-crossing-weather.p.rapidapi.com/history"
            querystring = {"startDateTime":list[1]+"T00:00:00","aggregateHours":"24","location":list[3],"endDateTime":list[2]+"T00:00:00","unitGroup":"us","dayStartTime":"00:00:00","contentType":"csv","dayEndTime":"23:59:59","shortColumnNames":"0"}

    # component of Get request
    headers = {
            "X-RapidAPI-Key": "569dff44dbmshe330a5ae719625ap19a992jsnc6ab914d18a2",
            "X-RapidAPI-Host": "visual-crossing-weather.p.rapidapi.com"
        }

    # storing the data following a csv structure 
    response = requests.request("GET", url, headers=headers, params=querystring)

    # if-else statement to check if data was collected
    if (response.startswith("Address,") == True):
    # saving the data from the variable in a csv file
        with open('./weatherdata.csv','w') as f:
            f.writelines(response.text)
    else: # if there's no data, raise an exception
        raise Exception()

except: # if a invalid respose 
    print("Something went wrong! Try running the script again with valid input.")
