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
player1Name=""
player2Name=""
player1Sign=""
player2Sign=""

function playerAssign(){
printf "Enter the first player name:\n"
read inputPlayer1
printf "Enter The second player name:\n"
read inputPlayer2
player1Name=$inputPlayer1
player2Name=$inputPlayer2
randomNumber=$(( RANDOM%2 ))
if [ $randomNumber -eq 0 ]
   then
      player1Sign="X"
      player2Sign="0"
   else
      player1Sign="0"
      player2Sign="X"
fi
printf "$player1Name = $player1Sign is Assigned\n"
printf "$player2Name = $player2Sign is Assigned\n"
}

#SHOW BOARD
function board(){
printf "[ $firstBlock ] [ $secondBlock ] [ $thirdBlock ] \n"
printf "[ $fourthBlock ] [ $fifthBlock ] [ $sixthBlock ] \n"
printf "[ $seventhBlock ] [ $eigthBlock ] [ $nineBlock ] \n"
playerAssign
}



board