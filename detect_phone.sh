#!/bin/bash
# author: Vasilis.Vlachoudis@cern.ch
# version: 0.0
# date: 6 Feb 2012

BTHW="xx:xx:xx:xx:xx:xx"  # Enter your Phone Bluetooth hardware address
LOCKPRG="gnome-screensaver"
UNLOCK_CMD="gnome-screensaver-command -d"
SLEEP=5

ME=`whoami`
while true
do	# Run only if screen is locked
	STATE=`LANG=en_US.utf8 gnome-screensaver-command -q 2>/dev/null`
	if (echo $STATE | grep " active$" &>/dev/null); then
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
