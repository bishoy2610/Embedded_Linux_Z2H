#!/bin/bash

#checking if the TRASH directory is created or not and if not, create it.
if [ -d ~/TRASH ]
then
	:
else
	mkdir ~/TRASH
fi

#checking if any archived files inside the TRASH directory has exceeded two days to permanently delete them.
find ~/TRASH -name *.tar.gz -type f -atime +2 -delete

#looping on the input files/directories to get them archived and put them inside the TRASH directory and remove the original files/directories permanently.
for i in $@
do
	if [ -f "$i" ] || [ -d "$i" ]
	then
		gzip -t $i 2>/dev/null
		if [[ $? -eq 0 ]]
		then
			mv $i ~/TRASH
		else
			tar czf $i.tar.gz $i
			mv $i.tar.gz ~/TRASH
			rm -r $i
		fi
	fi

done
