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

#ASSIGNED PLAYERS
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

#CHECK PLAYER NAME WITH SIGN
function playerName(){
if [[ $1 == $player1Sign ]]
   then
      echo $player1Name
   else
      echo $player2Name
fi
}

#CHANGE PLAYER SIGN
function changePlayer(){
   if [[ $1 == $player1Sign ]]
      then 
         echo $player2Sign
      else  
         echo $player1Sign
   fi
}
 
#BEGIN GAME
function begin(){
while [ $turnCount -ne 9 ]
do   
   if [ $turnCount -eq 0 ]
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
board
}

#PLAY
function play(){
board
printf "$( playerName $1 ) now its your turn ( $1 ) please enter the Position:\n"
read position
if [[ $position -lt 0 || $position -gt 9 ]]
   then
      printf '%s\n' "--------- Please enter valid number between 1-9 -----------\n"
      play $1
   else
      if [[ ${board[$position]} == "X" || ${board[$position]} == "0" ]]
         then 
            printf '%s\n' "----------- position is alrady assigned please select another position ---------------\n"
            play $1
         else  
            board[$position]=$1
      fi
fi
}

#SHOW BOARD
function board(){
printf " ${board[1]} | ${board[2]} | ${board[3]} \n"
printf " ${board[4]} | ${board[5]} | ${board[6]} \n"
printf " ${board[7]} | ${board[8]} | ${board[9]} \n"
}

board
playerAssign