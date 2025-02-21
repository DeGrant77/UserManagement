#! /bin/bash
#
# Author: Deli DeGrant
#

# For Stage 1
# Use this function to print out the help message for -h
# or if the user does not provide a valid argument.
#
function print_usage () {

	
	# Add your implementation of print_usage here
	echo -e "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account\n"
	echo -e "myuseradd.sh -d <login> - remove a user account\n"
	echo -e "myuseradd.sh -h  -dispaly this usage message\n"
}



# For Stage 2:
# Use this function to delete users as described in the
# assignment instructions.
# 
# Arguments : userToDelete
#
function delete_user () {
	local userToDelete="$1"
	if id "$userToDelete" &>/dev/null; then
		userdel -r "$userToDelete"
		echo "$userToDelete is deleted"
	else
		echo "ERROR: $userToDelete does not exist"
	fi
}



# For Stage 3:
# Use this function to add users as described in the
# assignment instructions
#
# Arguments : userToAdd, userPassword, shell
# 
function add_user () {
	local userToAdd="$1"
	local userPassword="$2"
	local shell="$3"

	if id "$userToAdd" &>/dev/null; then
		echo "ERROR: $userToAdd exist"
	else
		useradd -m -s "$shell" "$userToAdd"
		echo "$userToAdd:$userPassword" | chpasswd
		echo "$userToAdd ($userPassword) with $shell is added"
	fi
}



# For Stage1:
# Use this function to parse the command line arguments
# provided to this script to determine which function
# to call.  Example, if -h is used, print_usage
#
function parse_command_options () {

# This is just pseudo code.  Look at the BASH Script
# tips document for an example of how to use case in BASH
#	case 
#	-h
#		print_usage
#	-d 
#		delete_user
#	-a
#		add_user

	local option="$1"
	local login="$2"
	local password="$3"
	local sh="$4"

	case "$option" in
	-h)
	   echo $(print_usage)
	;;
	-d)
	   echo $(delete_user "$login" )
	;;
	-a)
	echo $(add_user "$login" "$password" "$sh")
	;;
	*)
	  echo "ERROR: Invalid option: $option"
	  echo	$(print_usage)
	;;
	esac
}


#
# This will run and call the parse_command_options function
# and pass all of the arguments to that function
#
parse_command_options "$1" "$2" "$3" "$4" 
