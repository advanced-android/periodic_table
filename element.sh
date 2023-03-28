PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo Please provide an element as an argument.
exit 0
fi

TEST=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
EXAM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
if [[ -z $TEST && -z $EXAM ]]
then
echo I could not find that element in the database.
exit 0
fi

if [[ -z $TEST ]]
then
NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE atomic_number=$1)")
MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE atomic_number=$1)")
BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE atomic_number=$1)")
echo The element with atomic number $NUMBER is $NAME \($SYMBOL\). It\'s a nonmetal, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius.
exit 0
else
NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1' OR name='$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1' OR name='$1'")
MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1')")
MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1')")
BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=(SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1')")
echo The element with atomic number $NUMBER is $NAME \($SYMBOL\). It\'s a nonmetal, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius.
exit 0
fi
