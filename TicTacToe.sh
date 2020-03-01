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
turnCount=0

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
begin
}

function playerName(){
if [ $1 == $player1Sign ]
   then
      echo $player1Name
   else
      echo $player2Name
fi
}

#GAME BEGIN
function begin(){
while [ $turnCount -ne 2 ]
do
   if [ $turnCount -eq 0 ]
      then
         randomNumber=$(( RANDOM%2 ))
         if [ $randomNumber -eq 0 ]
            then
               play $player1Sign 
            else  
               play $player2Sign
         fi
         (( turnCount++ ))
      else 
         (( turnCount++ ))
   fi
done
}

#PLAY
function play(){
board
printf "$( playerName $1 ) now its your turn ( $1 ) please enter the Position:\n"
read position
printf "position $position is selected\n"
}

#SHOW BOARD
function board(){
printf "[ $firstBlock ] [ $secondBlock ] [ $thirdBlock ] \n"
printf "[ $fourthBlock ] [ $fifthBlock ] [ $sixthBlock ] \n"
printf "[ $seventhBlock ] [ $eigthBlock ] [ $nineBlock ] \n"
}

board
playerAssign