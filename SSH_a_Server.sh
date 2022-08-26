#!/bin/bash 

## Task 
# Copy the IP addresses below into a
# file. Once you have done that, create a dynamic
# script that will allow the user to select an IP and
# automatically SSH into one of the IPs.

echo "Pick an IP Address from the list -->"
cat ips.txt
echo "-----------------------------"
echo "Enter your input below:"
read ipaddress;

match=$(grep -w $ipaddress ips.txt);
 
echo "Thank you for the input. Moving on to the next step.."


# Check if the IP address address match the IPs in the text file
if [[ $match = "$ipaddress"? ]]
then
echo "The IP address is a match. Redirecting to SSH server..."
echo "-----------------------------"
ssh -i private.pem ubuntu@$ipaddress;
exit 0;
else 
echo "The IP address does not match. Please try again!";
echo "-----------------------------"
exit 1;
fi