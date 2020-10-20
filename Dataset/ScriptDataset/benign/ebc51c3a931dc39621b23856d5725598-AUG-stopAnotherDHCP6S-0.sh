#!/bin/sh
## $1 => interface name
## pid path example ==> "/var/run/dhcp6s_br1.pid"
if [ -f  /var/run/dhcp6s_$1.pid ]; then
	kill -SIGTERM `cat /var/run/dhcp6s_$1.pid`
	rm -f /var/run/dhcp6s_$1.pid
fi
