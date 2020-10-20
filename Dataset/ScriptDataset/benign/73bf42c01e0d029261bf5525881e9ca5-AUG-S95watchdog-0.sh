#!/bin/sh
echo [$0]: $1 ... > /dev/console
case "$1" in
start)
	if [ -f "/etc/scripts/xmldb_watchdog.sh" ]; then
		/etc/scripts/xmldb_watchdog.sh &
	fi
	;;
stop)
	if [ -f "/etc/scripts/xmldb_watchdog.sh" ]; then
		killall xmldb_watchdog.sh
	fi
	;;
*)
	echo [$0]: Invalid argument - $1 > /dev/console
	;;
esac
