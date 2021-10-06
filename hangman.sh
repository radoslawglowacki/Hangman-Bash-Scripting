#! /bin/bash

Words=('Poland' 'Germany' 'England' 'France' 'Spain')

function selectWord(){
size=${#Words[@]}
index=$(($RANDOM % $size))
echo ${Words[$index]}
}

function preparingDashes(){
len=`expr length $1`
local Dashes=()
for ((i=0; i < len; i++)); do
	Dashes+=('_')
done 
echo ${Dashes[@]}
}

function gameDifficult(){
select level in EASY MEDIUM HARD
do
	case $level in
	EASY)
		echo 9
		return;;
	MEDIUM)
		echo 6
		return;;
	HARD)
		echo 3
		return;;
	*)
		echo "ERROR! Please select between 1..3";;
	esac
done
}

function mainMenu(){

echo "
Welcome in simple Hangman Game written by Radoslaw Glowacki in Bash Script

                  Select Difficult Level and have fun!
"
}


function displayStats(){
clear
echo "
Word to guess: $1

Used letters: $3

Chances: $2
"
}

# TODO
# function to check result
# main game engine


function game(){
local SelectedWord=$(selectWord)
local Dashes=$(preparingDashes $SelectedWord)
local UsedLetters=()
local Chances=$(gameDifficult)

displayStats "${Dashes[@]}" $UsedLetters $Chances

}


function main(){
mainMenu
game
}

main