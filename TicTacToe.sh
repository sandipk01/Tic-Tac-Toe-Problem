#!/bin/bash
printf '%s\n' "------------------  Tic-Tac-Toe  -----------------"

#VARIABLES
firstBlock=1
secondBlock=2
thirdBlock=3
fourthBlock=4
fifthBlock=5
sixthBlock=6
seventhBlock=7
eigthBlock=8
nineBlock=9

#SHOW BOARD
function board(){
printf "[ $firstBlock ] [ $secondBlock ] [ $thirdBlock ] \n"
printf "[ $fourthBlock ] [ $fifthBlock ] [ $sixthBlock ] \n"
printf "[ $seventhBlock ] [ $eigthBlock ] [ $nineBlock ] \n"
}

board