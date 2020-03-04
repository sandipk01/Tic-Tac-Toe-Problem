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
corner=(1 3 7 9)
#ASSIGNED SIGN TO FIRST AND SECOND PLAYER
function playerAssign(){
   local gameMode=$1
   if [[ $gameMode == 1 ]]
      then
         printf "Enter the first player name:\n"
         read inputPlayer1
         printf "Enter The second player name:\n"
         read inputPlayer2
         player1Name=$inputPlayer1
         player2Name=$inputPlayer2
      elif [[ $gameMode == 2 ]]
         then
            printf "Enter yout Player name:\n"
            read inputPlayer1
            player1Name=$inputPlayer1
            player2Name="computer"
   fi
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
local result=0
#COMPUTER PLAY
if [[ "$( playerName $1 )" == $computer ]]
   then
      printf "$( playerName $1 ) now its your turn ( $1 ) please enter the Position:\n"
      while [[ $isStop == 0 ]]
      do
         if [[ "$( computerWin $1 )" != 0 ]]
            then
               result="$( computerWin $1 )"
               break
            elif [[ "$( blockplayer $1 )" != 0 ]]
               then 
                  result="$( blockplayer $1 )"
                  break
            elif [[ "$( corners )" != 0 ]]
               then
                  result="$( corners )"
                  break
            elif [[ "$( findMid )" != 0 ]]
               then
                  result="$( findMid )"
                  break
            else
                  randomNumber=$(( ( RANDOM%9 ) + 1 ))
               if [[ "$( isEmpty $randomNumber )" == true ]]
                  then
                     result=$randomNumber
               fi
         fi
      done 
                  board[$result]=$1
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
function checkWin()
{
   local isWin=0
   local player=$1
   local row=1
   local column=1
   while [[ $row -le 9 ]]
   do
      if [[ "${board[$row]}" == $player && "${board[$(( $row + 1 ))]}" == $player && "${board[$(( $row + 2 ))]}" == $player ]] 
         then
            isWin=1
            break
      fi
      row=$(( $row + 3 ))  
   done
   while [[ $column -le 3 ]]
   do
      if [[ "${board[$column]}" == $player && "${board[$(( $column + 3 ))]}" == $player && "${board[$(( $column + 6 ))]}" == $player ]] 
         then
            isWin=1
            break
      fi
      column=$(( $column + 1 ))
   done
   #FOR CROSS WINING CHECK 
   if [[ "${board[1]}" == $player && "${board[5]}" == $player && "${board[9]}" == $player ]] 
         then
            isWin=1
         elif [[ "${board[3]}" == $player && "${board[5]}" == $player && "${board[7]}" == $player ]] 
         then
            isWin=1
   fi
   echo $isWin
}
#Box IS EMPTY
function isEmpty()
{
   if [[ "${board[$1]}" != "X" && "${board[$1]}" != "0" ]]
      then  
         echo true
      else
         echo false
   fi
}
#CHECK CORNERS ARE AVAILABLE
function corners()
{
   local index=0
   local result=0
   while [[ $index -le 3 ]]
   do
      if [[ "$( isEmpty ${corner[$index]} )" == true ]]
         then
            result="${corner[$index]}"
            break
      fi
      (( index++ ))
   done
   echo $result
}
#FINDING CENTER POSITION IS AVALIABLE
function findMidd()
{
   local result=0
   if [[ "$( isEmpty 5 )" == true ]]
      then 
         result=5
   fi
   echo $result
}
#FIND ANY EMPTY POSITION ON BOARD
function findAnyEmptyPosition()
{
   local result=0
   local index=1
   while [[ $index -le 9 ]]
   do
      if [[ "$( isEmpty $index )" == true ]]
         then
            result=$index
            break
      fi
      (( index++ ))
   done
   echo $result
}
#MAKE COMPUTER WIN
function computerWin(){
local player=$1
local row=1
local result=0
local column=1
local cross=1
while [[ $row -le 9 ]]
do
   result=0
   if [[ "${board[$row]}" == $player && "${board[$(( $row + 1 ))]}" == $player && $( isEmpty $(( $row + 2 )) ) == true ]] 
      then
         result=$(( $row + 2 ))
         break
   fi
   if [[ "${board[$row]}" == $player && "${board[$(( $row + 2 ))]}" == $player && $( isEmpty $(( $row + 1 )) ) == true ]] 
      then
         result=$(( $row + 1 ))
         break
   fi
   if [[ "${board[$(( $row + 1 ))]}" == $player && "${board[$(( $row + 2 ))]}" == $player && $( isEmpty $row ) == true ]] 
      then
         result=$row
         break
   fi
   row=$(( $row + 3 ))
done
while [[ $column -le 3 ]]
do
   if [[ "${board[$column]}" == $player && "${board[$(( $column + 3 ))]}" == $player && $( isEmpty $(( $column + 6 )) ) == true ]] 
      then
         result=$(( $column + 6 ))
         break
   fi
   if [[ "${board[$column]}" == $player && "${board[$(( $column + 6 ))]}" == $player && $( isEmpty $(( $column + 3 )) ) == true ]] 
      then
         result=$(( $column + 3 ))
         break
   fi
   if [[ "${board[$(( $column + 3 ))]}" == $player && "${board[$(( $column + 6 ))]}" == $player && $( isEmpty $column ) == true ]] 
      then
         result=$column 
         break
   fi
   column=$(( $column + 1 ))
done
   if [[ "${board[1]}" == $player && "${board[5]}" == $player && $( isEmpty 9 ) == true ]] 
      then
         result=9 
      elif [[ "${board[1]}" == $player && "${board[9]}" == $player && $( isEmpty 5 ) == true ]] 
      then
         result=5 
      elif [[ "${board[5]}" == $player && "${board[9]}" == $player && $( isEmpty 1 ) == true ]] 
      then
         result=1 
      elif [[ "${board[3]}" == $player && "${board[5]}" == $player && $( isEmpty 7 ) == true ]] 
      then
         result=7 
      elif [[ "${board[3]}" == $player && "${board[7]}" == $player && $( isEmpty 5 ) == true ]] 
      then
         result=5 
      elif [[ "${board[5]}" == $player && "${board[7]}" == $player && $( isEmpty 3 ) == true ]] 
      then
         result=3 
   fi
echo $result
}

#COMPUTER BLOCK PLAYER
function blockplayer()
{
   local opponent="$( changePlayer $1 )"
   echo "$( computerWin $opponent )"
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
   echo ${#board[@]}
   echo $(( 9/2 ))
   playerAssign 1
   ;;
   2)
   playerAssign 2
esac
