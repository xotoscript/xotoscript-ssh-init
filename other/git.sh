#!/bin/bash

source ./config.sh

############ # PROMPT GIT USER   ############

echo -e "${GREEN}Select the user you would like :${RESET_COLOR}"

COUNTER=0
for entry in "${users[@]}"; do
	((COUNTER = COUNTER + 1)) 
	echo -e "\t$COUNTER. $entry"
done

read -p "KEY # : " KEY_INDEX

echo ""
if [[ $KEY_INDEX =~ ^[1-9]\d*$ && $KEY_INDEX -le $COUNTER ]]; then
	((SELECTED_INDEX = $KEY_INDEX - 1))
	SELECTED_KEY=${users[$SELECTED_INDEX]}
else
	echo -e "${RED}Invalid key${RESET_COLOR}"
	exit 2
fi

echo -e "${GREEN}User Selected :${RESET_COLOR}" $SELECTED_KEY

############ # AFFECT GIT USER  ############

git config --global user.username "$SELECTED_KEY"
git config --global user.name "$SELECTED_KEY"
git config --global user.email "$SELECTED_KEY" + "@gmail.com"

cd "${CWD}"
