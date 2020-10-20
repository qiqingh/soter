#!/bin/sh
MYNAME=router_status_ticker
SLEEP_TIME=$1
TICK_INTERVAL=$2
if [ $# -ne 2 ]; then
   echo "Usage: $MYNAME <sleep-time> <tick-interval>" >&2
   exit 3
fi
echo "${MYNAME}: Sleeping ${SLEEP_TIME}ms to ensure a random schedule"
usleep $(expr $SLEEP_TIME \* 1000)
echo "${MYNAME}: Now ticking (${TICK_INTERVAL}-second interval)" >> /dev/console
while true; do
   sysevent set router_status-tick
   sleep $TICK_INTERVAL
done
