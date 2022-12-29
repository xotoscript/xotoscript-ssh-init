#!/bin/bash

source ./config.sh

############  # PROMPT SSH  ############

echo -e "${GREEN}Please answer those questions in order to clone and prepare your repository with SSH ${RESET_COLOR}"
echo ""

cd ~/.ssh
KEYS=$(find . -name "*.pub")

eval $(ssh-agent -s)

ssh-add -D

echo ""
COUNTER=0
echo -e "${GREEN}Select the SSH to use with your repository :${RESET_COLOR}"

for entry in $KEYS; do
	[[ $entry =~ ^(.+)\.pub$ ]]
	((COUNTER = COUNTER + 1))
	echo -e "\t$COUNTER. ${BASH_REMATCH[1]}"
done
echo ""

read -p "KEY # : " KEY_INDEX

if [[ $KEY_INDEX =~ ^[1-9]\d*$ && $KEY_INDEX -le $COUNTER ]]; then
	((SELECTED_INDEX = $KEY_INDEX - 1))
	# USERS=($KEYS)
	[[ ${ARR[$SELECTED_INDEX]} =~ ^(.+)\.pub$ ]]
	SELECTED_KEY=${BASH_REMATCH[1]}
else
	echo -e "${RED}Invalid key${RESET_COLOR}"
	exit 2
fi

############ # AFFECT SSH ADD  ############

echo ""

ssh-add $SELECTED_KEY

echo ""
