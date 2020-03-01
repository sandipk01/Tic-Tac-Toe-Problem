#!/bin/bash
printf '%s\n' "------------------  Tic-Tac-Toe  -----------------"

#VARIABLES
declare -a board
board[1]="1"
board[2]="2"
board[3]="3"
board[4]="4"
board[5]="5"
board[6]="6"
board[7]="7"
board[8]="8"
board[9]="9"
player1Name=""
player2Name=""
player1Sign=""
player2Sign=""
turnCount=0
currentPlayer=""

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
if [[ $1 == $player1Sign ]]
   then
      echo $player1Name
   else
      echo $player2Name
fi
}

function changePlayer(){
   if [[ $1 == $player1Sign ]]
      then 
         echo $player2Sign
      else  
         echo $player1Sign
   fi
}

#GAME BEGIN
function begin(){
while [ $turnCount -ne 9 ]
do
   if [ $turnCount -eq 1 ]
      then
         randomNumber=$(( RANDOM%2 ))
         if [ $randomNumber -eq 0 ]
            then
               currentPlayer=$player1Sign
               play $player1Sign 
            else  
               currentPlayer=$player2Sign
               play $player2Sign
         fi
         (( turnCount++ ))
      else 
        currentPlayer="$( changePlayer $currentPlayer )"
        play $currentPlayer 
         (( turnCount++ ))
   fi
done
}

function checkValidPosition(){
if [ $1 -lt 0 -a $1 -gt 9 ]
   then
      printf "Enter The valid position\n"
      play $2
   else
      if [ $(( ${board[$1]} )) -eq "X" -o $(( ${board[$1]} )) -eq "0" ]
         then 
            printf "position is alrady occupied please chech the board and enter empty position\n"
            play $2
         else  
            echo $1
      fi
fi
}

#PLAY
function play(){
board
printf "$( playerName $1 ) now its your turn ( $1 ) please enter the Position:\n"
read position
validatedPosition="$(checkValidPosition $position $1)"
board[$validatedPosition]=$1
}

#SHOW BOARD
function board(){
printf "[ ${board[1]} ] [ ${board[2]} ] [ ${board[3]} ] \n"
printf "[ ${board[4]} ] [ ${board[5]} ] [ ${board[6]} ] \n"
printf "[ ${board[7]} ] [ ${board[8]} ] [ ${board[9]} ] \n"
}

board
playerAssign