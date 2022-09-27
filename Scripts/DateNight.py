# Build an interactive script for a date night at a restaurant

import time
print("")
print(">>>>>>>>>>>>>>>> WELCOME TO LOVERS NEST <<<<<<<<<<<<<<<<<<<")
print("")
## User Input
name = input("What is your name? >> ")
date = input("What is your date's name? >> ")
print("")
print(">>>>>>>>>>>>>>>> Good Evening!", name, "&", date, "<<<<<<<<<<<<<<<<<<<")
print("")

budget = int(input("How much would you like to spend today? >> "))
print("-------------------------------------------------------")
print("Thank you! Here is the menu...")
print("Pick an item between 1 and 4. \nFor the options of each item -> pick between 1 and 3.")

menu = {
 "Basil Fried Rice": ["Shrimp", "Chicken", "Veggie"],
 "Drunken Noodles": ["Beef", "Pork", "Egg"],
 "Sushi": ["California Roll", "Spicy Tuna", "Dragon Roll"],
 "Pizza": ["Cheese", "Pepperoni", "Veggie-Lovers"],
}
price = [40, 60, 80, 100]
print("-------------------------------------------------------")

while (True):
    ############################### Show the Menu ################################
## For Loop
    n = 1
    for item in menu:
        print("[", n, "]", item," : ", menu[item])
        n += 1

    print("-------------------------------------------------------")
    #######################################################################
## Getting inputs from customer
    totalPrice = 0
    choice1 = int(input("What can I get you today? >> "))
    choice2 = int(input("What option would you like for the item? >> "))
    print("-------------------------------------------------------")
    choice3 = int(input("Would you like to share the dish [pick 0] or pick another item for your date? >> "))
    choice4 = int(input("What option would you like for the 2nd item? >> "))
    print("-------------------------------------------------------")
## Placing the choices in a nested list
    itemList = [[choice1, choice2], [choice3, choice4]]

    print("Here are the items you picked...")
    totalPrice = 0
    for item in itemList:
            if (item[0] != 0):
                print(">> ", list(menu.values())[item[0]-1][item[1]-1], list(menu.keys())[item[0]-1])
                totalPrice += price[item[0]-1]
            else:
                continue
    print("-------------------------------------------------------")
    time.sleep(3)

########################################################################
    def rating():
        print("How did you like your experience? Pick a number between 1 and 3.")
        print("")
        response2 = int(input("Select from the list below --> \n[1] Disgusting. Ruined my date! \n[2] Meh! Edible.. \n[3] Not bad. Can be better! \n[4] Made in heaven!!! \n>> "))

        if (response2 > 2):
            if (itemList[1][0] == 0):
                print("You are not getting another date!")
            else:
                print("Thank you for the feedback. You are definitely getting a 2nd date. Congrats!!")
        else:
            print("Sorry, we could not provide a good experience. \nHere is a 20% discount for your next meal! You can use it next month.")

#########################################################################

    if (totalPrice <= budget):
        print("Here is your meal. Enjoy your evening!!!!")
        print("")
        print("Your Total Price is $", totalPrice)
        print("Amount left from your budget is $", budget-totalPrice)
        print("-------------------------------------------------------")
        time.sleep(3)
        rating()
        break
    else:
        print("Sorry your budget of $", budget, "does not meet the total price of $", totalPrice)
        print("-------------------------------------------------------")
        response = input("Would you like to pick different items? >> ")
        if(response == "y"):
            print("-------------------------------------------------------")
            print("-------------------------------------------------------")
            continue
        else:
            print("Sorry for the inconvinence. Have a good evening!")
            break

print("-------------------------------------------------------")
