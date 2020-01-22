#!/bin/bash
clear

#checking if the database file is created or not and if not create it.
if [ -f /home/$USER/Documents/phonebookDB.txt ]
then
	:
else
	touch /home/$USER/Documents/phonebookDB.txt
fi

#if condition on the input parameter number 1 which will represent which option the user has entered and if this parameter is not entered just print the options with their description.
if [ -n "$1" ]
then
	#cheching if the entered option is -i.
	if [ $1 == "-i" ]
	then
		#checking if the second parameter is entered or not which is the first name of the contact that the 		user wants to enter.
		if [ -n "$2" ]
		then
			#checking if the third parameter is entered or not which is the second name of the contact that the 			user wants to enter.
			if [ -n "$3" ]
			then
				#checking if the forth parameter is entered or not which is the number of the contact that 					the user wants to enter.
				if [ -n "$4" ]
				then
					#appending the entered contact to the database file.
					echo "$2 $3 $4" >> /home/$USER/Documents/phonebookDB.txt
				fi
			fi
		else
			echo "please enter the name and the number that you want to save in the phonebook after the option."
		fi

	#cheching if the entered option is -v.
	elif [ $1 == "-v" ]
	then
		#cat command to view all the database file.
		cat /home/$USER/Documents/phonebookDB.txt

	#cheching if the entered option is -s.
	elif [ $1 == "-s" ]
	then
		if [ -n "$2" ]
		then
			if [ -n "$3" ]
			then
				#grep command to search for the first and second name of a contact.
				grep -h "$2 $3" /home/$USER/Documents/phonebookDB.txt
			else
				echo "please, enter both first and second name of the required contact."
			fi
		else
			echo 'please enter the contact name, that you are seareching for, after the option.'
		fi

	#cheching if the entered option is -e.
	elif [ $1 == "-e" ]
	then
		#deleting all the contacts
		> /home/$USER/Documents/phonebookDB.txt

	#cheching if the entered option is -d.
	elif [ $1 == "-d" ]
	then
		if [ -n "$2" ]
		then
			if [ -n "$3" ]
			then
				#searching for which line that contains the required contact to delete.
				var=$(grep -n "$2 $3" /home/$USER/Documents/phonebookDB.txt | cut -c1)
				#delete this line and redirecting the rest in a new temporary file called "file.txt"
				sed "$var d" /home/$USER/Documents/phonebookDB.txt > file.txt
				#copying the "file.txt" to the database file.
				cat file.txt > /home/$USER/Documents/phonebookDB.txt
				#removing the temporary file.
				rm file.txt
			fi			
		else
			echo 'please enter the contact name, that you want to delete, after the option.'
		fi
	else
		echo "the entered option is not recognized."
	fi

else
	echo "-i -->Insert new contact name and number."
	echo "-v -->View all saved contacts details."
	echo "-s -->Search by contact name."
	echo "-e -->Delete all records."
	echo "-d -->Delete only one contact name."
fi
