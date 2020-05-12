#!/bin/zsh

# Author: Andrew W. Johnson
# Date: 2020.05.12.
# Version 1.00
# Organization: Stony Brook Univeristy/DoIT

# This script will do an initial set of the user's desktop. It makes use of the utility
# desktoppr created by Armin Briegel at scriptingosx (https://github.com/scriptingosx/desktoppr).
#
# After this script runs it will not run again for non administrtor uses because it checks 
# for a desktoppr file placed in the following location: $HOME/Library/dockutil.
# This way users can further modify the dock to their desires.
#
# This needs to run in conjunction with a LaunchAgent to get it to run at login.

sleep 5

	# Get my user logging in.
myUser=$( /usr/bin/who | /usr/bin/egrep -i console | /usr/bin/awk '{print $1}' )

	# File so not to run again.
myFile="/Users/${myUser}/Library/desktoppr"
echo ${myFile}

	# If the users is one of our possible local administrators, set the background.
if [[ ${myUser} = "admin" || ${myUser} = "desktopsupport" || ${myUser} = "DesktopSupport" ]]; then
	/usr/local/bin/desktoppr /Library/Desktop\ Pictures/SBURed.jpg
	/usr/local/bin/desktoppr scale stretch
else
		# if the file exists do not run this again. This sets the desktop on first log in, allowing users to later change it.
	if [ ! -f "${myFile}" ]; then
		/bin/echo "${myFile} doesn't exist changing desktop."
		touch "${myFile}"
		/usr/local/bin/desktoppr /Library/Desktop\ Pictures/SBURed.jpg
		/usr/local/bin/desktoppr scale stretch
	else
		/bin/echo "Desktop has already been set once for user ${myUser}."
	fi
fi

exit 
