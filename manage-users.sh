# !/bin/bash
UserExist()
{
   awk -F":" '{ print $1 }' /etc/passwd | grep -x $1 > /dev/null
   return $?
}
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
		  	printf 'Username :\t'
		  	read un
		  	UserExist $un
			if [ $? = 0 ] ; then

				printf "${RED}Warning: This user already exists${NC}\nplease enter to continue............"
				read
			else
				printf "Full Name :\t"
				read fn;
				printf "Home Directory Leave blank for default :\t"
				read hd;
				printf "Select Following Available Shell or Leave blank for default : \n"
				tail -n +2 /etc/shells
				printf "Enter Shell :\t"
				read sl;
				printf "Password:\t"
				read -s ps;
				printf "\n"
				useradd $un
				if [ -z "$ps" ]; then
					echo -e "$ps\n$ps" | sudo passwd $un
				fi
			fi
		fi
	  ;; 
	  2)
	  if [[ $EUID -ne 0 ]]; then
	  		printf "${RED}you don't have permission to delete user${NC}\n"
	  	else
		  	printf "Enter username:\t"
		  	read un;
		  	UserExist $un
		  	if [ $? = 0 ] ; then
				read -p "What is your first name? " ans
				if [ [ $ans =~ ^[Yy]$ ] && [ -d "/home/$un" ] ]
				then
					userdel -r $un
					echo "delete with dir"
				else
					userdel $un
				fi
			else
				printf "${RED}Warning: user $un does not exist${NC}"
			fi
		fi
	  ;; 
	  3)
	  if [[ $EUID -ne 0 ]]; then
	  		printf "${RED}you don't have permission to modify user${NC}\n"
	  	else
		  	echo "you selected 3"
		fi
	  ;; 
	  4)
	  	printf "Last 10 Created Users:\n"
	  	awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
	  ;;
	  5)res='quit'
	  	exit 1
	  ;;
	esac
done
