#!/bin/sh

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
ForcedUpdate=`sysevent get fwup_forced_update`

if [ "$ForcedUpdate" == "0" ]; then
	echo "fwupd_fail" > /proc/bdutil/leds
	#start MU detect again
	MU_PID=`sysevent get MU_monitor_PID`
	if [ "${MU_PID}" != "" ]; then
		kill ${MU_PID}
	fi
	/etc/led/MU-monitor.sh&
else
	pidof fwupd-led.sh > /dev/null
	if [ $? = 0 ]; then
		killall fwupd-led.sh
	fi
	/etc/led/fwupd-led.sh fu_failed &
fi

