#!/bin/bash

############ COLORS   ############

WHITE="\033[1;37m"
RED="\033[0;31m"
RESET_COLOR="\033[0m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

############ PROMPT SSH  ############

echo -e "${GREEN}Please answer those questions in order to clone and prepare your repository with SSH ${RESET_COLOR}"
echo ""
CWD=$(pwd)
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
	[[ ${ARR[$SELECTED_INDEX]} =~ ^(.+)\.pub$ ]]
	SELECTED_KEY=${BASH_REMATCH[1]}
else
	echo -e "${RED}Invalid key${RESET_COLOR}"
	exit 2
fi

############ AFFECT SSH ADD  ############

echo ""

ssh-add $SELECTED_KEY

echo ""

############ PROMPT GIT USER   ############

declare -a users=(
	"xotosphere"
	"gregcousin126"
	"xotopio"
	"gregoire.cousin"
)

COUNTER=0
echo -e "${GREEN}Select the user you would like :${RESET_COLOR}"

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

############ AFFECT GIT USER  ############

echo "$SELECTED_KEY"

git config --global user.username "$SELECTED_KEY"
git config --global user.name "$SELECTED_KEY"
git config --global user.email "$SELECTED_KEY" + "@gmail.com"

cd "${CWD}"
