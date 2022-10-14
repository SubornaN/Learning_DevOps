class BankAccount:
  nums = 1000
  def __init__(self, name, balance):
    self.name = name
    self.balance = balance

    print("\n--Create an account--")
    self.pin = input("Enter your new pin: ")
    self.accountNum = BankAccount.nums
    BankAccount.nums += 1
    self.transactions = []
    print("\nThank you for opening a new account!")
    print(f"Account Name: {self.name} | Account #{self.accountNum} | Account Balance: ${self.balance}")
  
  # make functions to check for correct pin number, withdraw money, make a deposit, transfer money, dictionaries to display transactions
  def verify_pin(self):
    userPin = input("Enter the pin --> ")

    if userPin != self.pin:
      print("The pin is INCORRECT.")
      return False
    else:
      print("You entered a correct pin.")
      return True

  def withdrawal(self):
    print("\n--Withdrawal--")
    withdraw = int(input("Enter the amount --> "))
    
    if self.verify_pin() == True:
      if self.balance >= withdraw:
        self.balance -= withdraw
        self.transactions.append({"withdrawal": withdraw})
        print(f"You withdraw ${withdraw} from account #{self.accountNum}. Your current balance is ${self.balance}")
      else:
        print("You don't have enough money in your account.")

  def deposit(self):
    print("\n--Deposit--")
    deposit = int(input("Enter the amount --> "))
    
    if self.verify_pin() == True:
      self.balance += deposit
      self.transactions.append({"deposit": deposit})
      print(f"You deposited ${deposit} to account #{self.accountNum}. Your new balance is ${self.balance}")

  def transfer(self, toAccnt):
    print("\n--Transfer--")
    amount = int(input("Enter the amount --> "))
    
    if self.verify_pin() == True:
      if self.balance >= amount:
        toAccnt.balance += amount
        self.balance -= amount
        self.transactions.append({"Transferred Out": amount})
        toAccnt.transactions.append({"Transferred In": amount})
        print(f"You transferred ${amount} from account #{self.accountNum} to {toAccnt.accountNum}.\nNew balance for account #{toAccnt.accountNum}: ${toAccnt.balance}\nNew balance for account #{self.accountNum}: ${self.balance} ")
      else:
        print(f"The transfer for amount ${amount} was unsuccessful. {toAccnt.accountNum} has insufficient balance!!")

  def transaction_history(self): 
    
    if self.verify_pin() == True:
      print("\n--Transaction History--")
      print(f"Account Number: #{self.accountNum}")
      for i in self.transactions:
        print(i)

  def runATM(self):
    print("\nWelcome! How can I assist you?")
    
    while True:

      userInput = int(input("Pick an option -- \n1. Withdraw \n2. Deposit \n>> "))
      if userInput == 1:
        self.withdrawal()
        response = input("Do you want to continue? [Y/n] ")
        if response in ["Y", "Yes", "y", "yes"]:
          continue
        else:
          break
      elif userInput == 2:
        self.deposit()
        response = input("Do you want to continue? [Y/n] ")
        if response in ["Y", "Yes", "y", "yes"]:
          continue
        else:
          break
      else:
        print("The option is invalid. Please try again!")
        break


account1 = BankAccount("Su", 100)
account2 = BankAccount("Avi", 150)

account1.runATM()
account1.transfer(account2)