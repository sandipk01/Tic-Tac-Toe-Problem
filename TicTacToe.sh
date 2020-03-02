#!/bin/bash
printf '%s\n' "------------------  Tic-Tac-Toe  -----------------"

#VARIABLES
declare -a board
board[1]="-"
board[2]="-"
board[3]="-"
board[4]="-"
board[5]="-"
board[6]="-"
board[7]="-"
board[8]="-"
board[9]="-"
player1Name=""
player2Name=""
player1Sign=""
player2Sign=""
turnCount=0
computer="computer"
currentPlayer=""

#ASSIGNED SIGN TO FIRST AND SECOND PLAYER
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

#ASSIGNING SIGN TO PLAYER AND COMPUTER
function playerAssignWithComputer(){
printf "Enter the player name:\n"
read inputPlayer1
player1Name=$inputPlayer1
player2Name=$computer
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
local isWin=0
#LOOPING TILL ALL POSITION NOT GETS FULL
while [ $turnCount -ne 9 ]
do 
   #WHO IS PLAYING FIRST
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
        #SWITCHING PLAYER
        currentPlayer="$( changePlayer $currentPlayer )"
        #CHECK IF PLAYER IS WIN
        isWin="$( checkWin $currentPlayer )"
         if [[ $isWin == 1 ]]
            then
               printf "$( playerName $currentPlayer ) is Winner\n"
               break
            else
               play $currentPlayer
               isWin="$( checkWin $currentPlayer )"
                  if [[ $isWin == 1 ]]
                     then
                        printf "$( playerName $currentPlayer ) is Winner\n"
                        break
                     else
                        (( turnCount++ ))
                  fi
         fi      
   fi
   isWin=0
done
   if [[ $isWin == 0 ]]
      then
         printf "Match is Tie\n"
   fi
board
}


#PLAY
function play(){
board
local isStop=0
#COMPUTER PLAY
if [[ "$( playerName $1 )" == $computer ]]
   then
      printf "$( playerName $1 ) now its your turn ( $1 ) please enter the Position:\n"
      while [[ $isStop == 0 ]]
      do
         randomNumber=$(( ( RANDOM%9 ) + 1 ))
            if [[ "${board[$randomNumber]}" != "X" && "${board[$randomNumber]}" != "0" ]]
               then
                  isStop=1 
                  board[$randomNumber]=$1
                  break
            fi
      done
   else
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
fi
}

#CHECK WINNER OR TIE
function checkWin(){
local isWin=0
while [[ $isWin == 0 ]]
do
   if [[ ${board[1]} == $1 && ${board[2]} == $1 && ${board[3]} == $1 ]]
      then
         isWin=1
         break
      elif [[ ${board[4]} == $1 && ${board[5]} == $1 && ${board[6]} == $1 ]]
         then
            isWin=1
            break
      elif [[ ${board[7]} == $1 && ${board[8]} == $1 && ${board[9]} == $1 ]]
         then
            isWin=1
            break
      elif [[ ${board[1]} == $1 && ${board[4]} == $1 && ${board[7]} == $1 ]]
         then
            isWin=1
            break
      elif [[ ${board[2]} == $1 && ${board[5]} == $1 && ${board[8]} == $1 ]]
         then 
            isWin=1
            break
      elif [[ ${board[3]} == $1 && ${board[6]} == $1 && ${board[9]} == $1 ]]
         then
            isWin=1
            break
      elif [[ ${board[1]} == $1 && ${board[5]} == $1 && ${board[9]} == $1 ]]
         then
            isWin=1
            break
      elif [[ ${board[3]} == $1 && ${board[5]} == $1 && ${board[7]} == $1 ]]
         then
            isWin=1
            break      
      else
            isWin=0
            break
   fi
done
echo $isWin
}

#Box IS EMPTY
function isEmpty(){
if [[ "${board[$1]}" != "X" && "${board[$1]}" != "0" ]]
   then  
      echo true
   else
      echo false
fi
}

#MAKE COMPUTER WIN
function computerWin(){
if [[ "${board[1]}" == $1 && "${board[2]}" == $1 && "$( isEmpty 3 )" == true ]]
   then
      echo 3
   elif [[ "${board[1]}" == $1 && "${board[3]}" == $1 && "$( isEmpty 2 )" == true ]]
   then
      echo 2
   elif [[ "${board[2]}" == $1 && "${board[3]}" == $1 && "$( isEmpty 1 )" == true ]]
   then
      echo 1
   elif [[ "${board[4]}" == $1 && "${board[5]}" == $1 && "$( isEmpty 6 )" == true ]]
   then
      echo 6
   elif [[ "${board[4]}" == $1 && "${board[6]}" == $1 && "$( isEmpty 5 )" == true ]]
   then
      echo 5
   elif [[ "${board[5]}" == $1 && "${board[6]}" == $1 && "$( isEmpty 4 )" == true ]]
   then
      echo 4
   elif [[ "${board[7]}" == $1 && "${board[8]}" == $1 && "$( isEmpty 9 )" == true ]]
   then
      echo 9
   elif [[ "${board[7]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 8 )" == true ]]
   then
      echo 8
   elif [[ "${board[8]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 7 )" == true ]]
   then
      echo 7
   elif [[ "${board[1]}" == $1 && "${board[5]}" == $1 && "$( isEmpty 9 )" == true ]]
   then
      echo 9
   elif [[ "${board[1]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 5 )" == true ]]
   then
      echo 5
   elif [[ "${board[5]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 1 )" == true ]]
   then
      echo 1
   elif [[ "${board[3]}" == $1 && "${board[5]}" == $1 && "$( isEmpty 9 )" == true ]]
   then
      echo 9
   elif [[ "${board[3]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 5 )" == true ]]
   then
      echo 5
   elif [[ "${board[5]}" == $1 && "${board[9]}" == $1 && "$( isEmpty 3 )" == true ]]
   then
      echo 3
fi
}

#MAKE COMPUTER WIN
function computerWin(){
   
}

#SHOW BOARD
function board(){
printf " ${board[1]}  |  ${board[2]}  |  ${board[3]} \n"
printf " ${board[4]}  |  ${board[5]}  |  ${board[6]} \n"
printf " ${board[7]}  |  ${board[8]}  |  ${board[9]} \n"
}

printf "you want to play with human or computer?\n"
printf "1 - for with human\n"
printf "2 - for with computer\n"
read choice
case $choice in
   1)
   board
   playerAssign
   ;;
   2)
   board
   playerAssignWithComputer
esac
