#!/bin/sh

#kill MU detect process
MU_PID=`sysevent get MU_monitor_PID`
if [ "${MU_PID}" != "" ]; then
	kill ${MU_PID}
fi

echo factory_reset > /proc/bdutil/leds

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

