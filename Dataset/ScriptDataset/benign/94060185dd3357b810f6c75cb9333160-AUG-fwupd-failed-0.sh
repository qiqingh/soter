#!/bin/sh

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
ForcedUpdate=`sysevent get fwup_forced_update`

pidof fwupd-led.sh > /dev/null
if [ $? = 0 ]; then
	killall fwupd-led.sh
fi

/etc/led/fwupd-led.sh fu_failed &

