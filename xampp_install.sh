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

if [ $os = c ]; then
        echo  -e "CentOS selected downloading packeges."
        yum install nano wget net-tools -y 2 > /dev/null

elif [ $os = u ]; then
        echo -e "Ubuntu selected downloading packeges"
        apt-get install nano wget net-tools -y
else
        echo -e "${redColour}Invalid option. Exiting...${endColour}"
        exit 1

fi

#Step 2
echo -e "\n${yellowColour}2.${endColour}${greenColour}Downloading XAMPP.${endColour}"
wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/7.4.29/xampp-linux-x64-7.4.29-1-installer.run/download -O xampp.run --no-check-certificate --progress=bar:force 2>&1

#Step 3
echo -e "\n${yellowColour}3.${emdColour}${greenColour}executing the file.${endColour}"
chmod 755 xampp.run
./xampp.run --mode unattended --unattendedmodeui minimal

#Step 4
cat finish_instalation

