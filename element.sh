#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
MAIN() {
  if [[ -z $1 ]]
  then
    echo -e "Please provide an element as an argument."
  else
    #echo "$1"
    ISNUM="^[0-9]+$"
    if [[ $1 =~ $ISNUM ]]
    then
      INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.atomic_number = $1")
      if [[ -z $INFO ]]
      then
        echo -e "I could not find that element in the database."
      else
        echo $INFO | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
      fi
    else
      INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, 
      melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties 
      USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.symbol ILIKE '$1' OR elements.name ILIKE '$1'")
      if [[ -z $INFO ]]
      then
        echo -e "I could not find that element in the database."
      else
        echo $INFO | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
      fi
    fi
  fi
}
MAIN $1
 