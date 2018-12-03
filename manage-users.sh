# !/bin/bash
while true;
do
	printf "\n---------------------------------------------------------\nWelcome to the User Management Application for $USER\n1. Create a new user.\n2. Delete a user.\n3. Modify a user.\n4. See last 10 created users.\n5. Quit\n   Choice: "
	read ch;
	printf "\n---------------------------------------------------------\n\n"
	# Switch Case to perform 
RED='\033[0;31m'
NC='\033[0m' # No Color
	case $ch in
	  1)
	  	if [[ $EUID -ne 0 ]]; then
	  		printf "${RED}you don't have permission to create user${NC}\n"
	  	else
		  	printf 'please enter username:\t'
		  	read un
			if getent passwd $un > /dev/null 2>&1; then

				printf "${RED}Warning: This user already exists${NC}\nplease enter to continue............"
				read
			else
				printf "Full Name: "
				read fn
				echo "you fn is $fn"
			fi
		fi
	  ;; 
	  2)
	  if [[ $EUID -ne 0 ]]; then
	  		printf "${RED}you don't have permission to delete user${NC}\n"
	  	else
		  	echo "you selected 2"
		fi
	  ;; 
	  3)
	  if [[ $EUID -ne 0 ]]; then
	  		printf "${RED}you don't have permission to modify user${NC}\n"
	  	else
		  	echo "you selected 3"
		fi
	  ;; 
	  4)res='last 10 user' 
	  ;;
	  5)res='quit'
	  	exit 1
	  ;;
	esac
done
