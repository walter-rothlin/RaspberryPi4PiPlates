#!/bin/bash


#@version 1.0
#@since 17.07.2017
#@help
#Help of command 'showFileHeader'
#
#This command prints the header of a file (with special formats).
#
#The first parameter that is not an option or belongs to an option
#is the filepath of the file to print the header of.
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
#	-p	The part (tag) of the header to be printed.
#		Parts are (by default) marked with an '@'.
#		Expects an argument after this option.
#
#	-t	Sets tag identifier (default '@').
#		Expects an argument after this option.
#
#	-s	Removes the tagname from the result.
#			
#End of help for command 'showFileHeader'


#Get path of script used for help file
filepath=`realpath $0`


file=""
requestedPart=""
tag="@"
short=false
callArgs="$*"
formattedCallArgs=$(formatArgs "${callArgs}" "p:;t:;s;h;-h;-help;v;-v;-version")

seeHelp="For more information, call 'showFileHeader --help'."
#Read Options
IFS=$'\n' read -rd '' -a formattedCallArgsArray <<<"$formattedCallArgs"
for arg in "${formattedCallArgsArray[@]}"; do
	case $arg in	
		-help|-h|h)		echo "$(bash showFileHeader $filepath -p help -s)"
						exit ;;	
		-version|-v|v)	echo "$(bash showFileHeader $filepath -p version)"
						exit ;;
		p=*)			requestedPart="${arg:2}" ;;
		t=*)			tag="${arg:2}" ;;
		s*)				short=true ;;
		invOpt*)		echo "Unexpected option: ${arg:7}"
						echo "$seeHelp"
						exit ;;
		args*)			if [[ $file = "" ]]; then file=${arg:5}
						else
							echo "Unexpected parameter: ${arg:5}"
							echo "$seeHelp"
							exit
						fi ;;
	esac
done

if [[ $file = "" ]]; then
	echo "You need to give the file as parameter."
	echo "$seeHelp"
	exit
fi

inVariable=false
#Read file line by line
while read -r line
do
	if [[ $line == \#* ]]; then
		if [[ $line == \# ]]; then line=""
		else line=$(echo "$line"| cut -c2-${#line}) #Remove leading "#";
		fi
		if [[ $line == $tag* ]] && (( ${#line} > 1 )); then
			line=$(echo "$line"| cut -c2-${#line}) #Remove leading "@"
			thisPart=$(echo "$line" | cut -d " " -f 1)
			valueStartIndex=$((${#thisPart}+2))
			if (( $valueStartIndex > ${#line} )); then
				thisValue=""
			else
				thisValue=$(echo "$line"| cut -c${valueStartIndex}-${#line})
			fi
			if [[ $requestedPart == "" ]] || [[ $requestedPart == $thisPart ]]; then
				if [ $short = true ]; then
					if [[ $thisValue != "" ]]; then echo "$thisValue"; fi
				else
					echo "${thisPart}: ${thisValue}"
				fi
				inVariable=true
			else
				inVariable=false
			fi
		elif [ "$inVariable" = true ]; then
			echo "$line"
		fi
	else
		inVariable=false
	fi
done < "$file"