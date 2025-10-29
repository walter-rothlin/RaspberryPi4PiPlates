#!/bin/bash

#@version 1.0
#@since 18.07.2017
#@help
#Help of command 'setHostname'
#
#This command changes the hostname of the system.
#At the end the user will be asked to reboot.
#The changes only apply after reboot.
#
#The first parameter has to be the new hostname to set.
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
#End of help for command 'setHostname'


#Get path of script used for help file
filepath=`realpath $0`
callArgs="$*"
formattedCallArgs=$(formatArgs "${callArgs}" "h;-h;-help;v;-v;-version")

newHostname=""

seeHelp="For more information, call 'setHostname --help'."
#Read Options
IFS=$'\n' read -rd '' -a formattedCallArgsArray <<<"$formattedCallArgs"
for arg in "${formattedCallArgsArray[@]}"; do
	case $arg in	
		-help|-h|h)		echo "$(bash showFileHeader $filepath -p help -s)"
						exit ;;	
		-version|-v|v)	echo "$(bash showFileHeader $filepath -p version)"
						exit ;;
		invOpt*)		echo "Unexpected option: ${arg:7}"
						echo "$seeHelp"
						exit ;;
		args*)			if [[ $newHostname = "" ]]; then newHostname=${arg:5}
						else
							echo "Unexpected parameter: ${arg:5}"
							echo "$seeHelp"
							exit
						fi ;;
	esac
done

if [[ $newHostname = "" ]]; then
	echo "You need to give the new hostname as parameter."
	echo "$seeHelp"
	exit
fi

if [[ $newHostname == $(hostname) ]]; then
	echo "$newHostname is already the hostname, no operation required."
	exit
fi

echo "Setting hostname to ${newHostname}"
hostnameFile="/etc/hostname"
hostsFile="/etc/hosts"

newHostsFileContent=""
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ $newHostsFileContent != "" ]]; then
		newHostsFileContent="${newHostsFileContent}\n"
	fi
    if [[ "$line" == "127.0.1.1"* ]]; then
		elements=($line)
		oldHostname=${elements[1]}
		lenghtWithoutHostname=$((${#line} - ${#oldHostname}))
		newLine=${line:0:lenghtWithoutHostname}
		newLine="${newLine}${newHostname}"
		newHostsFileContent="${newHostsFileContent}${newLine}"
	else
		newHostsFileContent="${newHostsFileContent}${line}"
	fi
done < /etc/hosts

echo -e ${newHostname} | sudo tee "$hostnameFile" > /dev/null 2>&1
echo -e ${newHostsFileContent} | sudo tee "$hostsFile" > /dev/null 2>&1

echo "Restart is required to apply the changes."
read -p "Restart now (Y/N)? " -n 1 -r
echo #line break
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Rebooting..."
	sudo sync > /dev/null 2>&1
    sudo reboot -f > /dev/null 2>&1
fi