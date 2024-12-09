#!/bin/bash

#@author Arno Rohner
#@version 1.0
#@since 17.07.2017
#@help
#Help of command 'showEnv'
#
#This command prints the envoirement variables.
#
#Options:
#
#INFORMATION OPTIONS (will only print information about this command)
#
#	-v, --v, --version	Prints the version of this script.
#
#	-h, --h, --help		Prints this help text.
#	
#
#MODIFICATION OPTIONS (modifies the output of this command)
#
#	-p	Filters the result with the given pattern.
#		The -p before the argument is not required.
#		Expects an argument after this option.
#	
#	-f	Formats the result.
#		It will split the variables by a delimiter.
#		You may define a delimiter after this option (default: ':')
#			
#End of help for command 'showEnv'

#Get path of script used for help file
filepath=`realpath $0`

#Getting options
formatted=false
delimiter=":"
patternArg=""
callArgs="$*"
formattedCallArgs=$(formatArgs "${callArgs}" "p+;f?;h;-h;-help;v;-v;-version")

seeHelp="For more information, call 'showEnv --help'."
#Read Options
IFS=$'\n' read -rd '' -a formattedCallArgsArray <<<"$formattedCallArgs"
for arg in "${formattedCallArgsArray[@]}"; do
	case $arg in	
		-help|-h|h)		echo "$(bash showFileHeader $filepath -p help -s)"
						exit ;;	
		-version|-v|v)	echo "$(bash showFileHeader $filepath -p version)"
						exit ;;
		p=*)			patternArg=${arg:2} ;;
		f)				formatted=true ;;
		f=*)			formatted=true
						delimiter=${arg:2} ;;
		invOpt*)		echo "Unexpected option: ${arg:7}"
						echo "$seeHelp"
						exit ;;
		args*)			if [[ $patternArg = "" ]]; then patternArg=${arg:5}
						else
							echo "Unexpected parameter: ${arg:5}"
							echo "$seeHelp"
							exit
						fi ;;
	esac
done

if [[ $patternArg = "" ]]; then patternArg=";"; fi #If no pattern is given delimiter is added so pattern '' will be used
IFS=';' read -ra patterns <<< "$patternArg"


allEnv="$(printenv)"
IFS=$'\n' read -rd '' -a envArray <<< "$allEnv"
headerName="Varibale Name"
headerValue="Variable Value"
nameLenght="${#headerName}"
filteredArrayIndex=0
for env in "${envArray[@]}"
do
	for pattern in "${patterns[@]}"; do
		if [[ "${env^^}" =~ "${pattern^^}" ]]
		then
			IFS='=' read -r name value <<< "$env"
			filteredNameArray[filteredArrayIndex]="$name"
			filteredValueArray[filteredArrayIndex]="$value"
			if (( "${#name}" > "$nameLenght" ))
			then
				nameLenght="${#name}"
			fi
			filteredArrayIndex="$((filteredArrayIndex+1))"
			break
		fi
	done
done

if [[ "$filteredArrayIndex" -eq "0" ]]
then
	echo "no envoirement variable matches the criteria(s): '${patternArg/;/\', \'}'"
	exit
fi

delimiterLine=`printf '%*s' "$((nameLenght+2))" | tr ' ' "-"`
for index in "${!filteredNameArray[@]}"
do
	thisName="${filteredNameArray[$index]}"
	thisNameLength="${#thisName}"
	amountOfSpaces="$((nameLenght-thisNameLength+1))"
	spaces=`printf '%*s' "$amountOfSpaces"`
	echo "$delimiterLine"
	if [ "$formatted" = true ]
	then
		IFS="$delimiter" read -r -a envValueArray <<< "${filteredValueArray[$index]}"
		echo "$thisName$spaces:"
		for envValue in "${envValueArray[@]}"
		do
			echo "$envValue"
		done
	else
		echo "$thisName$spaces: ${filteredValueArray[$index]}"
	fi
done
echo "$delimiterLine"

