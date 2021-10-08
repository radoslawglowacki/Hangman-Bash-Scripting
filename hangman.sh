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

Used letters: $2

Chances: $3
"
}

function readUserInput(){
while true; 
do
   read -p "Enter one lowercase letter: " VAR
if [[ "${VAR}" =~ [^a-z] ]] || [ ${#VAR} -gt 1 ]; then
    continue
else
    echo $VAR
	return
fi
done

}

function wordContainsLetter(){

local word=$1
local letter=$2

if [[ "${word,,}" == *"$letter"* ]]; then
	echo true
else
	echo false 
fi

}

function fillPlacesByLetter(){

local word=$1
local letter=$2
local dashes=$3
local newDashes=()

for ((i = 0 ; i < ${#word} ; i++)); do
  if [[ ${word:i:1} == *"$letter"* ]]; then
		newDashes+=$letter
	else
		newDashes+="_"
	fi
	if [[ $i < "$((${#word}-1))" ]];
	then
		newDashes+=" "
		fi
done

echo ${newDashes[@]}
}

function checkWin(){

local Dashes=$1

if [[ ! " ${Dashes[*]} " =~ "_" ]]; then
    echo true
else
	echo false
fi
}



function game(){
local SelectedWord=$(selectWord)
local Dashes=$(preparingDashes $SelectedWord)
local UsedLetters=()
Chances=$(gameDifficult)

while (( $Chances >=0 )); do
clear
displayStats "${Dashes[@]}" $UsedLetters $Chances
local Input=$(readUserInput)

if [[ $(wordContainsLetter $SelectedWord $Input) ]]; then
		Dashes=$(fillPlacesByLetter $SelectedWord $Input "${Dashes[@]}")
	else
		let Chances=$Chances-1
fi
	UsedLetters+=$Input
: '
if [[ $(checkWin "${Dashes[@]}") ]]; then
	break
fi
'
done
echo  

}


function main(){
mainMenu
game
}

main



#local Input=$(readUserInput)
#echo $Input
#local contain=$(wordContainsLetter Blaska b)
#echo $contain 
: '
local SelectedWord=$(selectWord)
local Dashes=$(preparingDashes $SelectedWord)

Dashes=$(fillPlacesByLetter $SelectedWord n "${Dashes[@]}")

echo "${Dashes[@]}"
'