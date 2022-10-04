#!/bin/bash

# Variable to hold command to query database
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\nWelcome to the Barbershop, please select a service:\n"

# Get available services from Database
SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

# Get Array of Valid Service IDs
SERVICE_ARRAY="$(echo $SERVICES | sed -r 's/([0-9]+) \| [a-zA-Z ]*/\1 /g')"
SERVICE_ARRAY=($SERVICE_ARRAY)
# echo ${#SERVICE_ARRAY[@]} check array has expected number of elements

# Main Service Selection Menu
MAIN_MENU () {

  # If an argument (info string) is passed to the function, print it
  if [[ ! -z $1 ]]
  then
    echo -e "$1"
  fi

  # List available services
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  # Get user service choice, check it exists in database
  read SERVICE_ID_SELECTED
  echo -e "\nSelected Service ID: $SERVICE_ID_SELECTED"

  # Check that this is a valid service
  for AVAILABLE_ID in "${SERVICE_ARRAY[@]}"     # expand the array indexes to a list of words
  do
    if [[ $AVAILABLE_ID = $SERVICE_ID_SELECTED ]]
    then
      # Get name of the selected service, stripping any leading or ending spaces:
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;" | sed -r 's/^ *| *$//')
      break
    fi
  done

  # If ID is not valid, return to services menu
  if [[ -z $SERVICE_NAME ]]
  then
    MAIN_MENU "\nSelected Service does not exist, please try again\n"
  fi

  # Try to book user for this service
  while [[ -z $CUSTOMER_PHONE ]]
  do
    echo -e "\nPlease enter your phone number:"
    read CUSTOMER_PHONE
  done

  # Check if customer with that phone number already exists, and trim spaces from start and end of name:
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';" | sed -r 's/^ *| *$//')

  if [[ -z $CUSTOMER_NAME ]]
  then
    # Get customer name
    while [[ -z $CUSTOMER_NAME ]]
    do
      echo -e "\nHello new customer! Please tell us your name: "
      read CUSTOMER_NAME
    done

    # Save new customer record in DB
    CUSTOMER_NAME_INSERT_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
    if [[ $CUSTOMER_NAME_INSERT_RESULT = "INSERT 0 1" ]]
    then
      echo -e "\nWelcome $CUSTOMER_NAME, we look forward to working with you!"
    fi
  else
    echo -e "\nWelcome back, $CUSTOMER_NAME!"
  fi

  # Get customer ID from DB
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

  # Get appointment time from user
  while [[ -z $SERVICE_TIME ]]
  do
    echo -e "\nWhat time would you like your appointment, $CUSTOMER_NAME?"
    read SERVICE_TIME
  done

  # Add appointment to DB
  APPOINTMENT_INSERT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

  if [[ $APPOINTMENT_INSERT_RESULT = "INSERT 0 1" ]]
  then
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  else
    echo -e "\nWhoops, something went wrong!\n"
    MAIN_MENU
  fi
}

# Run script
MAIN_MENU
