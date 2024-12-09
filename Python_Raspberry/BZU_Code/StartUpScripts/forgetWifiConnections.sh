#!/bin/bash

wpaSupplicantFile="/etc/wpa_supplicant/wpa_supplicant.conf"
inNetwork=false
newFileContent=""
oldFileContent=$(sudo cat $wpaSupplicantFile)
IFS=$'\n' read -rd '' -a oldFileLines <<<"$oldFileContent"

for line in "${oldFileLines[@]}"; do
		if [[ "$line" == "network"* ]]; then
			inNetwork=true
		fi
		
		if [ "$inNetwork" = false ] && [[ "$line" != "" ]]; then
			if [[ "$newFileContent" == "" ]]; then
				newFileContent="$line"
			else
				newFileContent="${newFileContent}\n${line}"
			fi
		fi
		if [[ "$line" == "}" ]]; then
			inNetwork=false
		fi
done

echo -e "$newFileContent" | sudo tee $wpaSupplicantFile > /dev/null 2>&1

echo "cleared $wpaSupplicantFile"