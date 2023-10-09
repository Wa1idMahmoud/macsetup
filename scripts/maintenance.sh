#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[0;36m'
NC='\033[0m' # NO COLOUR

# Prints a message in a specified colour
# Parameter 1: The message to print.
# Parameter 2: The colour to print the message in.
printInfoLine() {

    msgToPrint=$1
    printColour=$2
    #Set Colour to $printColour.
    echo -e "${printColour}"
    boxText "${msgToPrint}"
    echo -e "${NC}"
    #echo -e "${printColour}\\n###### ${msgToPrint} ######\\n${NC}"
    #Set colour to No Colour NC.



}

boxText() {
    wordLength=${#1}
    repeatChar '-' $(($wordLength + 4))
    echo -e "\n| ${1} |"
    repeatChar '-' $(($wordLength + 4))
    echo -e "\n"
}

repeatChar() {
    for i in $(seq 1 $2);
    do 
    echo -n "$1";
    done
}


printInfoLine "Ubuntu update starting, fetching updated package list" ${YELLOW}

echo -e "${CYAN}"

sudo apt-get update

echo -e ${NC}

printInfoLine "installing updated packages." ${YELLOW}

echo -e "${CYAN}"

sudo apt-get upgrade -y

echo -e ${NC}

printInfoLine "Removing redundant packages." ${RED}

echo -e "${CYAN}"

sudo sudo apt autoremove -y

echo -e ${NC}

printInfoLine "DONE! " ${GREEN}

exit 0

