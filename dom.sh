#!/usr/bin/env bash

# Add these to a config file eventually
create_agent() { sudo -u named /named/bin/agent-zone-create.sh; }
create_office() { sudo -u named /named/bin/office-zone-create.sh; }
update_agent() { echo 'Command not available'; }
update_office() { echo 'Command not available'; }

if [ $# -eq 0 ] # No arguments. Do menu of options instead.'
then
	menu=(
		"Create new agent zone."
		"Update agent zone."
		"Create new office zone"
		"Update office zone."
		"Help"
		"Quit")	
	title="Domain Administration"
	invalid="Invalid. Must be 1-${#menu[@]}"
	help="Printing help..."
	
	printf "\n\e[1m%s\e[0m\n" "$title" # escape sequences print bold
	# PS3 is the prompt variable that is used to define the prompt
	# string displayed by the 'select' command, which creates a menu
	PS3="   Choose an option: "
	select opt in "${menu[@]}"; do
		case "$REPLY" in
			1) create_agent;  exit 0;;
			2) update_agent;  exit 0;;
			3) create_office; exit 0;;
			4) update_office; exit 0;;
			5) echo "$help";;
			6) exit 0;;
			*) printf "\e[31m%s\e[0m\n" "$invalid" # print in red
		esac
	done
	exit 0 #Do I need this?
fi

usage='usage: domain [-c | -u] [-a | -o][-h]'
errormessage() {
	echo "$usage"
	exit 1
}
optnum=1

# Script was called with arguments, so parse them.
while getopts :cuaoh opt; do
	case $opt in
		h)	echo "$usage"
			exit 0;;
		c)	if [ "$cflag" ]
				then errormessage
				else cflag=1
			fi;;
		u)	if [ "$uflag" ]
				then errormessage
				else uflag=1
			fi;;
		a)	if [ "$aflag" ]
				then errormessage
				else aflag=1
			fi;;
		o)	if [ "$oflag" ]
				then errormessage
				else oflag=1
			fi;;
	esac
	if [ "$optnum" -gt 2 ] #Too many options
		then errormessage
		else ((optnum++))
	fi
done

# Parse flags and run commands.
if [ "$cflag" -a "$aflag" ]
then
	create_agent
elif  [ "$cflag" -a "$oflag" ]
then
	create_office
elif  [ "$uflag" -a "$aflag" ]
then
	update_agent
elif  [ "$uflag" -a "$oflag" ]
then
	update_office
else
	errormessage
fi

