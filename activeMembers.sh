#!/usr/bin/env bash
#################################################################################################################
# Script that calculates the active members of a club.                                                          #
# Requirements: all of the attendance must be exported to .csv files and be in the same directory as the script #
# Club name should be the first arg (one word)                                                                  #
# Author:  Michael Vessia                                                                                       #
#################################################################################################################

# check for correct number of args
if [ $# != 1 ]; then
	echo Incorrect number of arguments passed to program.  Exiting...
	exit
fi
# put all of the content of the csv files into one file
cat *.csv > temp

# grep for lines containing emails, and put that into another file
grep -o [A-Za-z]*@mail.adelphi.edu temp > temp2

#remove the email extension, so we are just left with names
sed 's/@mail.adelphi.edu//g' temp2 > temp3

#make everything lower case, to avoid any issues with someone who was manually inputted with different case
tr '[:upper:]' '[:lower:]' < temp3 > temp4

#sort the file, and pipe to uniq for the count of how many meetings they came to
(sort temp4 | uniq -c) > temp5

#Definition of an active member at Adelphi is someone who came to 3 or more meetings. 
(grep '[1-9]*[3-9]' temp5 && grep '[1-9][0-9]' temp5) > activeMembers.txt


# put active members in a file and output results to console.
echo The Active Members for $1 are currently:
cat activeMembers.txt
var=$(cat activeMembers.txt | wc -l)
echo The number of active members for $1 are: $var

rm temp*
