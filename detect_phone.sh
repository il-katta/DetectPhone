#!/bin/bash
# author: Vasilis.Vlachoudis@cern.ch
# version: 0.0
# date: 6 Feb 2012

BTHW="xx:xx:xx:xx:xx:xx"  # Enter your Phone Bluetooth hardware address
DESKTOP="gnome"


SLEEP=5 

ME=`whoami`

case "$DESKTOP" in
	"gnome" | "GNOME")
		UNLOCK_CMD="gnome-screensaver-command -d"
		STATE_CMD="gnome-screensaver-command -q | grep \" active$\""
		export LC_ALL="en_US.utf-8"
		;;
	"kde" | "KDE" )
		LOCKPRG="kscreenlocker"
		UNLOCK_CMD="kill `pgrep -u $ME $LOCKPRG | head -1`"
		STATE_CMD="pgrep -u $ME $LOCKPRG"
		;;
	*) 
		exit 1 
		;;
esac

while true
do	# Run only if screen is locked
	if ( $STATE_CMD &>/dev/null ); then
		# Ping the phone (needs sudo permissions
		# chmod u+s /usr/bin/l2ping
		l2ping -t 5 -c 1 $BTHW >/dev/null 2>/dev/null
		RC=$?
		if [ $RC = 0 ]; then
			# Phone present...
			$UNLOCK_CMD
			xset dpms force on
		fi
	fi
	sleep $SLEEP
done
