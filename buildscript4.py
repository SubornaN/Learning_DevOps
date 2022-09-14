import requests, subprocess # importing the modules

# running the bash script in Python
subprocess.run(["./buildscript4.sh"])

# saving the user inputs from the bash script in a text file to use with python
with open('params.txt','r') as f:
    lines = f.readlines()

# taking the data from the file and making it into a list
list=[]
for line in lines:
    list.append(line.strip())

# if-else statement to do API call based on user selection: forecast data or historical data
if list[0] == "1": # forecast data
    url = "https://visual-crossing-weather.p.rapidapi.com/forecast"
    querystring = {"aggregateHours":"24","forecastDays":list[1],"location":list[2],"contentType":"csv","unitGroup":"us","shortColumnNames":"true"}

elif list[0] == "2": # historical data
    url = "https://visual-crossing-weather.p.rapidapi.com/history"
    querystring = {"startDateTime":list[1]+"T00:00:00","aggregateHours":"24","location":list[3],"endDateTime":list[2]+"T00:00:00","unitGroup":"us","dayStartTime":"00:00:00","contentType":"csv","dayEndTime":"23:59:59","shortColumnNames":"0"}
else: # if a invalid respose 
    print("Something went wrong! Try running the script again with proper input format.")

# component of Get request
headers = {
        "X-RapidAPI-Key": "Paste the API key",
        "X-RapidAPI-Host": "visual-crossing-weather.p.rapidapi.com"
    }

# storing the data following a csv structure 
response = requests.request("GET", url, headers=headers, params=querystring)

# saving the data from the variable in a csv file
with open('weatherdata.csv','w') as f:
    f.writelines(response.text)