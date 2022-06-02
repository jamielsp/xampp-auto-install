#!/bin/bash

#Function wget progress bar
progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%c' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#echo -e "\n${yellowColour}[*]${endColour}${grayColour} Exiting...${endColour}"

#Step 1
echo -e "\n${yellowColour}1.${emdColour}${greenColour}Installing requeriments.${endColour}"
echo -e "Which System u use \n${purpleColour}c (CentOS)${endColour} / ${purpleColour}u {Ubuntu}${endColour}  ?"
read os

if [ $os = c ];
then
	echo  -e "CentOS selected downloading packeges."
	yum install nano wget -y 2 > /dev/null

	if [ $os = u ];
	then
		echo -e "Ubuntu selected downloading packeges"
		apt-get install nano wget -y 2 > /dev/null
	fi
fi

#Step 2
echo -e "\n${yellowColour}2.${emdColour}${greenColour}Downloading Xammp.${endColour}"

wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.1.6/xampp-linux-x64-8.1.6-0-installer.run/download -O xampp.run --no-check-certificate --progress=bar:force 2>&1 | progressfilt

#Step 3
echo -e "\n${yellowColour}3.${emdColour}${greenColour}executing the file.${endColour}"
chmod 755 xampp.run
./xampp.run

#Step 4
cat finish_instalation